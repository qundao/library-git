#### Perforce

下一个将要看到导入的系统是 Perforce。 就像我们之前讨论过的，有两种方式让
Git 与 Perforce 互相通信：git-p4 与 Perforce Git Fusion。

##### Perforce Git Fusion

Git Fusion 使这个过程毫无痛苦。 只需要使用在
[\[\_p4_git_fusion\]](#_p4_git_fusion)
中讨论过的配置文件来配置你的项目设置、用户映射与分支，然后克隆整个仓库。
Git Fusion 让你处在一个看起来像是原生 Git
仓库的环境中，如果愿意的话你可以随时将它推送到一个原生 Git 托管中。
如果你喜欢的话甚至可以使用 Perforce 作为你的 Git 托管。

##### Git-p4

Git-p4 也可以作为一个导入工具。 作为例子，我们将从 Perforce
公开仓库中导入 Jam 项目。 为了设置客户端，必须导出 P4PORT 环境变量指向
Perforce 仓库：

```shell
$ export P4PORT=public.perforce.com:1666
```

[TABLE]

运行 `git p4 clone` 命令从 Perforce 服务器导入 Jam
项目，提供仓库、项目路径与你想要存放导入项目的路径：

```shell
$ git-p4 clone //guest/perforce_software/jam@all p4import
Importing from //guest/perforce_software/jam@all into p4import
Initialized empty Git repository in /private/tmp/p4import/.git/
Import destination: refs/remotes/p4/master
Importing revision 9957 (100%)
```

这个特定的项目只有一个分支，但是如果你在分支视图（或者说一些目录）中配置了一些分支，你可以将
`--detect-branches` 选项传递给 `git p4 clone` 来导入项目的所有分支。
查看 [\[\_git_p4_branches\]](#_git_p4_branches)
来了解关于这点的更多信息。

此时你几乎已经完成了。 如果进入 `p4import` 目录中并运行
`git log`，可以看到你的导入工作：

```shell
$ git log -2
commit e5da1c909e5db3036475419f6379f2c73710c4e6
Author: giles <giles@giles@perforce.com>
Date:   Wed Feb 8 03:13:27 2012 -0800

    Correction to line 355; change </UL> to </OL>.

    [git-p4: depot-paths = "//public/jam/src/": change = 8068]

commit aa21359a0a135dda85c50a7f7cf249e4f7b8fd98
Author: kwirth <kwirth@perforce.com>
Date:   Tue Jul 7 01:35:51 2009 -0800

    Fix spelling error on Jam doc page (cummulative -> cumulative).

    [git-p4: depot-paths = "//public/jam/src/": change = 7304]
```

你可以看到 `git-p4` 在每一个提交里都留下了一个标识符。 如果之后想要引用
Perforce 的修改序号的话，标识符保留在那里也是可以的。
然而，如果想要移除标识符，现在正是这么做的时候——在你开始在新仓库中工作之前。
可以使用 `git filter-branch` 将全部标识符移除。

```shell
$ git filter-branch --msg-filter 'sed -e "/^\[git-p4:/d"'
Rewrite e5da1c909e5db3036475419f6379f2c73710c4e6 (125/125)
Ref 'refs/heads/master' was rewritten
```

如果运行 `git log`，你会看到所有提交的 SHA-1
校验和都改变了，但是提交信息中不再有 `git-p4` 字符串了：

```shell
$ git log -2
commit b17341801ed838d97f7800a54a6f9b95750839b7
Author: giles <giles@giles@perforce.com>
Date:   Wed Feb 8 03:13:27 2012 -0800

    Correction to line 355; change </UL> to </OL>.

commit 3e68c2e26cd89cb983eb52c024ecdfba1d6b3fff
Author: kwirth <kwirth@perforce.com>
Date:   Tue Jul 7 01:35:51 2009 -0800

    Fix spelling error on Jam doc page (cummulative -> cumulative).
```

现在导入已经准备好推送到你的新 Git 服务器上了。

Last updated 2024-03-09 10:37:44 +0800
