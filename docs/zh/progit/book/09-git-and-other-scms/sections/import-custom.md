#### 一个自定义的导入器

如果你的系统不是上述中的任何一个，你需要在线查找一个导入器——针对许多其他系统有很多高质量的导入器，
包括 CVS、Clear Case、Visual Source Safe，甚至是一个档案目录。
如果没有一个工具适合你，需要一个不知名的工具，或者需要更大自由度的自定义导入过程，应当使用
`git fast-import`。 这个命令从标准输入中读取简单指令来写入特定的 Git
数据。 通过这种方式创建 Git 对象比运行原始 Git 命令或直接写入原始对象
（查看
[ch10-git-internals](ch10-git-internals.md#ch10-git-internals)
了解更多内容）更容易些。
通过这种方式你可以编写导入脚本，从你要导入的系统中读取必要数据，然后直接打印指令到标准输出。
然后可以运行这个程序并通过 `git fast-import` 重定向管道输出。

为了快速演示，我们会写一个简单的导入器。 假设你在 `current`
工作，有时候会备份你的项目到时间标签 `back_YYYY_MM_DD`
备份目录中，你想要将这些导入到 Git 中。 目录结构看起来是这样：

```shell
$ ls /opt/import_from
back_2014_01_02
back_2014_01_04
back_2014_01_14
back_2014_02_03
current
```

为了导入一个 Git 目录，需要了解 Git 如何存储它的数据。 你可能记得，Git
在底层存储指向内容快照的提交对象的链表。 所有要做的就是告诉
`fast-import` 哪些内容是快照，哪个提交数据指向它们，以及它们进入的顺序。
你的策略是一次访问一个快照，然后用每个目录中的内容创建提交，并且将每一个提交与前一个连接起来。

如同我们在
[ch08-customizing-git](ch08-customizing-git.md#an_example_git_enforced_policy)
里做的， 我们将会使用 Ruby
写这个，因为它是我们平常工作中使用的并且它很容易读懂。
可以使用任何你熟悉的东西来非常轻松地写这个例子——它只需要将合适的信息打印到
`标准输出`。 然而，如果你在 Windows
上，这意味着需要特别注意不要引入回车符到行尾—— `git fast-import`
非常特别地只接受换行符（LF）而不是 Windows 使用的回车换行符（CRLF）。

现在开始，需要进入目标目录中并识别每一个子目录，每一个都是你要导入为提交的快照。
要进入到每个子目录中并为导出它打印必要的命令。 基本主循环像这个样子：

```shell
last_mark = nil

# loop through the directories
Dir.chdir(ARGV[0]) do
  Dir.glob("*").each do |dir|
    next if File.file?(dir)

    # move into the target directory
    Dir.chdir(dir) do
      last_mark = print_export(dir, last_mark)
    end
  end
end
```

在每个目录内运行
`print_export`，将会拿到清单并标记之前的快照，然后返回清单并标记现在的快照；通过这种方式，可以将它们合适地连接在一起。
“标记”是一个给提交标识符的 `fast-import`
术语；当你创建提交，为每一个提交赋予一个标记来将它与其他提交连接在一起。
这样，在你的 `print_export`
方法中第一件要做的事就是从目录名字生成一个标记：

```shell
mark = convert_dir_to_mark(dir)
```

可以创建一个目录的数组并使用索引做为标记，因为标记必须是一个整数。
方法类似这样：

```shell
$marks = []
def convert_dir_to_mark(dir)
  if !$marks.include?(dir)
    $marks << dir
  end
  ($marks.index(dir) + 1).to_s
end
```

既然有一个整数代表你的提交，那还要给提交元数据一个日期。
因为目录名字表达了日期，所以你将会从中解析出日期。 你的 `print_export`
文件的下一行是：

```shell
date = convert_dir_to_date(dir)
```

`convert_dir_to_date` 定义为：

```shell
def convert_dir_to_date(dir)
  if dir == 'current'
    return Time.now().to_i
  else
    dir = dir.gsub('back_', '')
    (year, month, day) = dir.split('_')
    return Time.local(year, month, day).to_i
  end
end
```

那会返回每一个目录日期的整数。
最后一项每个提交需要的元数据是提交者信息，它将会被硬编码在全局变量中：

```shell
$author = 'John Doe <john@example.com>'
```

现在准备开始为你的导入器打印出提交数据。
初始信息声明定义了一个提交对象与它所在的分支，紧接着一个你生成的标记、提交者信息与提交信息、然后是一个之前的提交，如果它存在的话。
代码看起来像这样：

```shell
# print the import information
puts 'commit refs/heads/master'
puts 'mark :' + mark
puts "committer #{$author} #{date} -0700"
export_data('imported from ' + dir)
puts 'from :' + last_mark if last_mark
```

我们将硬编码时区信息（-0700），因为这样很容易。
如果从其他系统导入，必须指定为一个偏移的时区。
提交信息必须指定为特殊的格式：

```shell
data (size)\n(contents)
```

这个格式包括文本数据、将要读取数据的大小、一个换行符、最终的数据。
因为之后还需要为文件内容指定相同的数据格式，你需要创建一个帮助函数，`export_data`：

```shell
def export_data(string)
  print "data #{string.size}\n#{string}"
end
```

剩下的工作就是指定每一个快照的文件内容。
这很轻松，因为每一个目录都是一个快照——可以在目录中的每一个文件内容后打印
`deleteall` 命令。 Git 将会适当地记录每一个快照：

```shell
puts 'deleteall'
Dir.glob("**/*").each do |file|
  next if !File.file?(file)
  inline_data(file)
end
```

注意：因为大多数系统认为他们的版本是从一个提交变化到另一个提交，fast-import
也可以为每一个提交执行命令来指定哪些文件是添加的、删除的或修改的与新内容是哪些。
可以计算快照间的不同并只提供这些数据，但是这样做会很复杂——也可以把所有数据给
Git 然后让它为你指出来。 如果这更适合你的数据，查阅 `fast-import` man
帮助页来了解如何以这种方式提供你的数据。

这种列出新文件内容或用新内容指定修改文件的格式如同下面的内容：

```shell
M 644 inline path/to/file
data (size)
(file contents)
```

这里，644 是模式（如果你有可执行文件，反而你需要检测并指定 755），inline
表示将会立即把内容放在本行之后。 你的 `inline_data` 方法看起来像这样：

```shell
def inline_data(file, code = 'M', mode = '644')
  content = File.read(file)
  puts "#{code} #{mode} inline #{file}"
  export_data(content)
end
```

可以重用之前定义的 `export_data`
方法，因为它与你定义的提交信息数据的方法一样。

最后一件你需要做的是返回当前的标记以便它可以传给下一个迭代：

```shell
return mark
```

[TABLE]

就是这样。 这是全部的脚本：

```shell
#!/usr/bin/env ruby

$stdout.binmode
$author = "John Doe <john@example.com>"

$marks = []
def convert_dir_to_mark(dir)
    if !$marks.include?(dir)
        $marks << dir
    end
    ($marks.index(dir)+1).to_s
end

def convert_dir_to_date(dir)
    if dir == 'current'
        return Time.now().to_i
    else
        dir = dir.gsub('back_', '')
        (year, month, day) = dir.split('_')
        return Time.local(year, month, day).to_i
    end
end

def export_data(string)
    print "data #{string.size}\n#{string}"
end

def inline_data(file, code='M', mode='644')
    content = File.read(file)
    puts "#{code} #{mode} inline #{file}"
    export_data(content)
end

def print_export(dir, last_mark)
    date = convert_dir_to_date(dir)
    mark = convert_dir_to_mark(dir)

    puts 'commit refs/heads/master'
    puts "mark :#{mark}"
    puts "committer #{$author} #{date} -0700"
    export_data("imported from #{dir}")
    puts "from :#{last_mark}" if last_mark

    puts 'deleteall'
    Dir.glob("**/*").each do |file|
        next if !File.file?(file)
        inline_data(file)
    end
    mark
end

# Loop through the directories
last_mark = nil
Dir.chdir(ARGV[0]) do
    Dir.glob("*").each do |dir|
        next if File.file?(dir)

        # move into the target directory
        Dir.chdir(dir) do
            last_mark = print_export(dir, last_mark)
        end
    end
end
```

如果运行这个脚本，你会得到类似下面的内容：

```shell
$ ruby import.rb /opt/import_from
commit refs/heads/master
mark :1
committer John Doe <john@example.com> 1388649600 -0700
data 29
imported from back_2014_01_02deleteall
M 644 inline README.md
data 28
# Hello

This is my readme.
commit refs/heads/master
mark :2
committer John Doe <john@example.com> 1388822400 -0700
data 29
imported from back_2014_01_04from :1
deleteall
M 644 inline main.rb
data 34
#!/bin/env ruby

puts "Hey there"
M 644 inline README.md
(...)
```

为了运行导入器，将这些输出用管道重定向到你想要导入的 Git 目录中的
`git fast-import`。 可以创建一个新的目录并在其中运行 `git init`
作为开始，然后运行你的脚本：

```shell
$ git init
Initialized empty Git repository in /opt/import_to/.git/
$ ruby import.rb /opt/import_from | git fast-import
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:       5000
Total objects:           13 (         6 duplicates                  )
      blobs  :            5 (         4 duplicates          3 deltas of          5 attempts)
      trees  :            4 (         1 duplicates          0 deltas of          4 attempts)
      commits:            4 (         1 duplicates          0 deltas of          0 attempts)
      tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
Total branches:           1 (         1 loads     )
      marks:           1024 (         5 unique    )
      atoms:              2
Memory total:          2344 KiB
       pools:          2110 KiB
     objects:           234 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =         10
pack_report: pack_mmap_calls          =          5
pack_report: pack_open_windows        =          2 /          2
pack_report: pack_mapped              =       1457 /       1457
---------------------------------------------------------------------
```

正如你所看到的，当它成功完成时，它会给你一串关于它完成内容的统计。
这本例中，一共导入了 13 个对象、4 次提交到 1 个分支。 现在，可以运行
`git log` 来看一下你的新历史：

```shell
$ git log -2
commit 3caa046d4aac682a55867132ccdfbe0d3fdee498
Author: John Doe <john@example.com>
Date:   Tue Jul 29 19:39:04 2014 -0700

    imported from current

commit 4afc2b945d0d3c8cd00556fbe2e8224569dc9def
Author: John Doe <john@example.com>
Date:   Mon Feb 3 01:00:00 2014 -0700

    imported from back_2014_02_03
```

做得很好——一个漂亮、干净的 Git 仓库。
要注意的一点是并没有检出任何东西——一开始你的工作目录内并没有任何文件。
为了得到他们，你必须将分支重置到 `master` 所在的地方：

```shell
$ ls
$ git reset --hard master
HEAD is now at 3caa046 imported from current
$ ls
README.md main.rb
```

可以通过 `fast-import`
工具做很多事情——处理不同模式、二进制数据、多个分支与合并、标签、进度指示等等。
一些更复杂情形下的例子可以在 Git 源代码目录中的 `contrib/fast-import`
目录中找到。

Last updated 2024-03-09 10:37:43 +0800
