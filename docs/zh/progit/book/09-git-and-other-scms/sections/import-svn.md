#### Subversion

如果你阅读过前面关于 `git svn` 的章节，可以轻松地使用那些指令来
`git svn clone` 一个仓库，停止使用 Subversion 服务器，推送到一个新的 Git
服务器，然后就可以开始使用了。 如果你想要历史，可以从 Subversion
服务器上尽可能快地拉取数据来完成这件事（这可能会花费一些时间）。

然而，导入并不完美；因为花费太长时间了，你可能早已用其他方法完成导入操作。
导入产生的第一个问题就是作者信息。 在 Subversion
中，每一个人提交时都需要在系统中有一个用户，它会被记录在提交信息内。
在之前章节的例子中几个地方显示了 `schacon`，比如 `blame` 输出与
`git svn log`。 如果想要将上面的 Subversion 用户映射到一个更好的 Git
作者数据中，你需要一个 Subversion 用户到 Git 用户的映射。 创建一个
`users.txt` 的文件包含像下面这种格式的映射：

```shell
schacon = Scott Chacon <schacon@geemail.com>
selse = Someo Nelse <selse@geemail.com>
```

为了获得 SVN 使用的作者名字列表，可以运行这个：

```shell
$ svn log --xml --quiet | grep author | sort -u | \
  perl -pe 's/.*>(.*?)<.*/$1 = /'
```

这会将日志输出为 XML 格式，然后保留作者信息行、去除重复、去除 XML 标记。
很显然这只会在安装了 `grep`、`sort` 与 `perl` 的机器上运行。
然后，将输出重定向到你的 `users.txt`
文件中，这样就可以在每一个记录后面加入对应的 Git 用户数据。

[TABLE]

你可以将此文件提供给 `git svn` 来帮助它更加精确地映射作者数据。
也可以通过传递 `--no-metadata` 给 `clone` 与 `init` 命令，告诉 `git svn`
不要包括 Subversion 通常会导入的元数据。在导入过程中，Git
会在每个提交说明的元数据中生成一个 `git-svn-id`。

[TABLE]

这会使你的 `import` 命令看起来像这样：

```shell
$ git svn clone http://my-project.googlecode.com/svn/ \
      --authors-file=users.txt --no-metadata --prefix "" -s my_project
$ cd my_project
```

现在在 `my_project` 目录中应当有了一个更好的 Subversion 导入。
并不像是下面这样的提交：

```shell
commit 37efa680e8473b615de980fa935944215428a35a
Author: schacon <schacon@4c93b258-373f-11de-be05-5f7a86268029>
Date:   Sun May 3 00:12:22 2009 +0000

    fixed install - go to trunk

    git-svn-id: https://my-project.googlecode.com/svn/trunk@94 4c93b258-373f-11de-
    be05-5f7a86268029
```

反而它们看起来像是这样：

```shell
commit 03a8785f44c8ea5cdb0e8834b7c8e6c469be2ff2
Author: Scott Chacon <schacon@geemail.com>
Date:   Sun May 3 00:12:22 2009 +0000

    fixed install - go to trunk
```

不仅是 Author 字段更好看了，`git-svn-id` 也不在了。

之后，你应当做一些导入后的清理工作。 第一步，你应当清理 `git svn`
设置的奇怪的引用。
首先移动标签，这样它们就是标签而不是奇怪的远程引用，然后你会移动剩余的分支这样它们就是本地的了。

为了将标签变为合适的 Git 标签，运行：

```shell
$ for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done
```

这会使原来在 `refs/remotes/tags/`
里的远程分支引用变成真正的（轻量）标签。

接下来，将 `refs/remotes` 下剩余的引用移动为本地分支：

```shell
$ for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $b refs/remotes/$b && git branch -D -r $b; done
```

你可能会看到一些额外的分支，这些分支的后缀是 `@xxx` (其中 xxx
是一个数字)，而在 Subversion 中你只会看到一个分支。这实际上是 Subversion
一个叫做“peg-revisions”的功能，Git在语法上没有与之对应的功能。因此，
`git svn` 只是简单地将 SVN peg-revision 版本号添加到分支名称中，这同你在
SVN 中修改分支名称来定位一个分支的“peg-revision”是一样的。如果你对于
peg-revisions 完全不在乎，通过下面的命令可以轻易地移除他们：

```shell
$ for p in $(git for-each-ref --format='%(refname:short)' | grep @); do git branch -D $p; done
```

现在所有的旧分支都是真正的 Git 分支，并且所有的旧标签都是真正的 Git
标签。

还有最后一点东西需要清理。`git svn` 会创建一个名为 `trunk`
的额外分支，它对应于 Subversion 的默认分支，然而 `trunk` 引用和 `master`
指向同一个位置。 鉴于在 Git 中 `master`
最为常用，因此我们可以移除额外的分支：

```shell
$ git branch -d trunk
```

最后一件要做的事情是，将你的新 Git 服务器添加为远程仓库并推送到上面。
下面是一个将你的服务器添加为远程仓库的例子：

```shell
$ git remote add origin git@my-git-server:myrepository.git
```

因为想要上传所有分支与标签，你现在可以运行：

```shell
$ git push origin --all
$ git push origin --tags
```

通过以上漂亮、干净地导入操作，你的所有分支与标签都应该在新 Git
服务器上。

Last updated 2024-03-09 10:37:45 +0800
