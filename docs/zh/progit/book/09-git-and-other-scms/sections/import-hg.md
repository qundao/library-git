#### Mercurial

因为 Mercurial 与 Git 在表示版本时有着非常相似的模型，也因为 Git
拥有更加强大的灵活性，将一个仓库从 Mercurial 转换到 Git
是相当直接的，使用一个叫作“hg-fast-export”的工具，需要从这里拷贝一份：

```shell
$ git clone https://github.com/frej/fast-export.git
```

转换的第一步就是要先得到想要转换的 Mercurial 仓库的完整克隆：

```shell
$ hg clone <remote repo URL> /tmp/hg-repo
```

下一步就是创建一个作者映射文件。 Mercurial
对放入到变更集作者字段的内容比 Git
更宽容一些，所以这是一个清理的好机会。 只需要用到 `bash`
终端下的一行命令：

```shell
$ cd /tmp/hg-repo
$ hg log | grep user: | sort | uniq | sed 's/user: *//' > ../authors
```

这会花费几秒钟，具体要看项目提交历史有多少，最终 `/tmp/authors`
文件看起来会像这样：

```shell
bob
bob@localhost
bob <bob@company.com>
bob jones <bob <AT> company <DOT> com>
Bob Jones <bob@company.com>
Joe Smith <joe@company.com>
```

在这个例子中，同一个人（Bob）使用不同的名字创建变更集，其中一个实际上是正确的，
另一个完全不符合 Git 提交的规范。hg-fast-export 通过对每一行应用规则
`"<input>"="<output>"` ，将 `<input>` 映射到 `<output>` 来修正这个问题。
在 `<input>` 和 `<output>` 字符串中，所有 Python 的 `string_escape`
支持的转义序列都会被解释。如果作者映射文件中并不包含匹配的 `<input>`，
那么该作者将原封不动地被发送到 Git。
如果所有的用户名看起来都是正确的，那我们根本就不需要这个文件。
在本例中，我们会使文件看起来像这样：

```shell
"bob"="Bob Jones <bob@company.com>"
"bob@localhost"="Bob Jones <bob@company.com>"
"bob <bob@company.com>"="Bob Jones <bob@company.com>"
"bob jones <bob <AT> company <DOT> com>"="Bob Jones <bob@company.com>"
```

当分支和标签 Mercurial 中的名字在 Git
中不允许时，这种映射文件也可以用来重命名它们。

下一步是创建一个新的 Git 仓库，然后运行导出脚本：

```shell
$ git init /tmp/converted
$ cd /tmp/converted
$ /tmp/fast-export/hg-fast-export.sh -r /tmp/hg-repo -A /tmp/authors
```

`-r` 选项告诉 hg-fast-export 去哪里寻找我们想要转换的 Mercurial
仓库，`-A` 标记告诉它在哪找到作者映射文件（分支和标签的映射文件分别通过
`-B` 和 `-T` 选项来指定）。 这个脚本会分析 Mercurial
变更集然后将它们转换成
Git“fast-import”功能（我们将在之后详细讨论）需要的脚本。
这会花一点时间（尽管它比通过网格 *更* 快），输出相当的冗长：

```shell
$ /tmp/fast-export/hg-fast-export.sh -r /tmp/hg-repo -A /tmp/authors
Loaded 4 authors
master: Exporting full revision 1/22208 with 13/0/0 added/changed/removed files
master: Exporting simple delta revision 2/22208 with 1/1/0 added/changed/removed files
master: Exporting simple delta revision 3/22208 with 0/1/0 added/changed/removed files
[…]
master: Exporting simple delta revision 22206/22208 with 0/4/0 added/changed/removed files
master: Exporting simple delta revision 22207/22208 with 0/2/0 added/changed/removed files
master: Exporting thorough delta revision 22208/22208 with 3/213/0 added/changed/removed files
Exporting tag [0.4c] at [hg r9] [git :10]
Exporting tag [0.4d] at [hg r16] [git :17]
[…]
Exporting tag [3.1-rc] at [hg r21926] [git :21927]
Exporting tag [3.1] at [hg r21973] [git :21974]
Issued 22315 commands
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:     120000
Total objects:       115032 (    208171 duplicates                  )
      blobs  :        40504 (    205320 duplicates      26117 deltas of      39602 attempts)
      trees  :        52320 (      2851 duplicates      47467 deltas of      47599 attempts)
      commits:        22208 (         0 duplicates          0 deltas of          0 attempts)
      tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
Total branches:         109 (         2 loads     )
      marks:        1048576 (     22208 unique    )
      atoms:           1952
Memory total:          7860 KiB
       pools:          2235 KiB
     objects:          5625 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit      = 8589934592
pack_report: pack_used_ctr            =      90430
pack_report: pack_mmap_calls          =      46771
pack_report: pack_open_windows        =          1 /          1
pack_report: pack_mapped              =  340852700 /  340852700
---------------------------------------------------------------------

$ git shortlog -sn
   369  Bob Jones
   365  Joe Smith
```

那看起来非常好。 所有 Mercurial 标签都已被转换成 Git 标签，Mercurial
分支与书签都被转换成 Git 分支。
现在已经准备好将仓库推送到新的服务器那边：

```shell
$ git remote add origin git@my-git-server:myrepository.git
$ git push origin --all
```

Last updated 2024-03-09 10:37:44 +0800
