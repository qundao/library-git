#### Git 与 Mercurial

DVCS 的宇宙里不只有 Git。
实际上，在这个空间里有许多其他的系统。对于如何正确地进行分布式版本管理，每一个系统都有自己的视角。
除了 Git，最流行的就是 Mercurial，并且它们两个在很多方面都很相似。

好消息是，如果你更喜欢 Git 的客户端行为但是工作在源代码由 Mercurial
控制的项目中，有一种使用 Git 作为 Mercurial 托管仓库的客户端的方法。
由于 Git
与服务器仓库是使用远程交互的，那么由远程助手实现的桥接方法就不会让人很惊讶。
这个项目的名字是 git-remote-hg，可以在
[https://github.com/felipec/git-remote-hg](https://github.com/felipec/git-remote-hg)
找到。

##### git-remote-hg

首先，需要安装 git-remote-hg。 实际上需要将它的文件放在 PATH
变量的某个目录中，像这样：

```shell
$ curl -o ~/bin/git-remote-hg \
  https://raw.githubusercontent.com/felipec/git-remote-hg/master/git-remote-hg
$ chmod +x ~/bin/git-remote-hg
```

假定 `~/bin` 在 `$PATH` 变量中。 Git-remote-hg
有一个其他的依赖：`mercurial` Python 库。 如果已经安装了
Python，安装它就像这样简单：

```shell
$ pip install mercurial
```

（如果未安装 Python，访问
[https://www.python.org/](https://www.python.org/) 来获取它。）

需要做的最后一件事是安装 Mercurial 客户端。 如果还没有安装的话请访问
[https://www.mercurial-scm.org/](https://www.mercurial-scm.org/)
来安装。

现在已经准备好摇滚了。 你所需要的一切就是一个你可以推送的 Mercurial
仓库。 很幸运，每一个 Mercurial
仓库都可以这样做，所以我们只需要使用大家用来学习 Mercurial 的“hello
world”仓库就可以了：

```shell
$ hg clone http://selenic.com/repo/hello /tmp/hello
```

##### 开始

既然有一个可用的 “server-side”
仓库，我们可以通过一个典型的工作流来了解。
你将会看到，这两种系统非常相似，没有太多的出入。

和 Git 一样，首先我们克隆：

```shell
$ git clone hg::/tmp/hello /tmp/hello-git
$ cd /tmp/hello-git
$ git log --oneline --graph --decorate
* ac7955c (HEAD, origin/master, origin/branches/default, origin/HEAD, refs/hg/origin/branches/default, refs/hg/origin/bookmarks/master, master) Create a makefile
* 65bb417 Create a standard "hello, world" program
```

你会注意到与 Mercurial 仓库工作时使用了标准的 `git clone` 命令。
那是因为 git-remote-hg 工作在相当低的底层，使用类似于 Git HTTP/S
协议的机制实现的（远程助手）。 由于 Git 与 Mercurial
都设计为每一个客户端有一个仓库的完整历史，所以这个命令做了一次完整的克隆，包括所有的项目历史，并且相当快地完成。

log 命令显示了两次提交，最后一次提交指向了一大堆引用。
那说明这其中的一部分实际上并没有在那儿。 让我们看看 `.git`
目录中实际上有什么：

```shell
$ tree .git/refs
.git/refs
├── heads
│   └── master
├── hg
│   └── origin
│       ├── bookmarks
│       │   └── master
│       └── branches
│           └── default
├── notes
│   └── hg
├── remotes
│   └── origin
│       └── HEAD
└── tags

9 directories, 5 files
```

Git-remote-hg 尝试让结构更有 Git
风格，但是在隐藏在下面的是它管理两个轻微不同系统之间概念的映射。
`refs/hg` 目录中存储了实际的远程引用。
例如，`refs/hg/origin/branches/default` 是一个包含以 “ac7955c” 开始的
SHA-1 值的 Git 引用文件，是 `master` 所指向的提交。 所以 `refs/hg`
目录是一种类似 `refs/remotes/origin`
的替代品，但是它引入了书签与分支的区别。

`notes/hg` 文件是 git-remote-hg 如何在 Git 的提交散列与 Mercurial 变更集
ID 之间建立映射的起点。 让我们来探索一下：

```shell
$ cat notes/hg
d4c10386...

$ git cat-file -p d4c10386...
tree 1781c96...
author remote-hg <> 1408066400 -0800
committer remote-hg <> 1408066400 -0800

Notes for master

$ git ls-tree 1781c96...
100644 blob ac9117f...  65bb417...
100644 blob 485e178...  ac7955c...

$ git cat-file -p ac9117f
0a04b987be5ae354b710cefeba0e2d9de7ad41a9
```

所以 `refs/notes/hg` 指向了一个树，即在 Git
对象数据库中的一个有其他对象名字的列表。 `git ls-tree` 输出 tree
对象中所有项目的模式、类型、对象哈希与文件名。 如果深入挖掘 tree
对象中的一个项目，我们会发现在其中是一个名字为 “ac9117f” 的 blob
对象（`master` 所指向提交的 SHA-1 散列值），包含内容 “0a04b98” （是
`default` 分支指向的 Mercurial 变更集的 ID）。

好消息是大多数情况下我们不需要关心以上这些。 典型的工作流程与使用 Git
远程仓库并没有什么不同。

在我们继续之前，这里还有一件需要注意的事情：忽略。 Mercurial 与 Git
使用非常类似的机制实现这个功能，但是一般来说你不会想要把一个
`.gitignore` 文件提交到 Mercurial 仓库中。 幸运的是，Git
有一种方式可以忽略本地磁盘仓库的文件，而且 Mercurial 格式是与 Git
兼容的，所以你只需将这个文件拷贝过去：

```shell
$ cp .hgignore .git/info/exclude
```

`.git/info/exclude` 文件的作用像是一个
`.gitignore`，但是它不包含在提交中。

##### 工作流程

假设我们已经做了一些工作并且在 `master`
分支做了几次提交，而且已经准备将它们推送到远程仓库。
这是我们仓库现在的样子：

```shell
$ git log --oneline --graph --decorate
* ba04a2a (HEAD, master) Update makefile
* d25d16f Goodbye
* ac7955c (origin/master, origin/branches/default, origin/HEAD, refs/hg/origin/branches/default, refs/hg/origin/bookmarks/master) Create a makefile
* 65bb417 Create a standard "hello, world" program
```

我们的 `master` 分支领先 `origin/master`
分支两个提交，但是那两个提交只存在于我们的本地机器中。
让我们看看在同一时间有没有其他人做过什么重要的工作：

```shell
$ git fetch
From hg::/tmp/hello
   ac7955c..df85e87  master     -> origin/master
   ac7955c..df85e87  branches/default -> origin/branches/default
$ git log --oneline --graph --decorate --all
* 7b07969 (refs/notes/hg) Notes for default
* d4c1038 Notes for master
* df85e87 (origin/master, origin/branches/default, origin/HEAD, refs/hg/origin/branches/default, refs/hg/origin/bookmarks/master) Add some documentation
| * ba04a2a (HEAD, master) Update makefile
| * d25d16f Goodbye
|/
* ac7955c Create a makefile
* 65bb417 Create a standard "hello, world" program
```

因为使用了 `--all` 标记，我们看到被 git-remote-hg 内部使用的 “notes”
引用，但是可以忽略它们。 剩下的部分是我们期望的；`origin/master`
已经前进了一次提交，同时我们的历史现在分叉了。 Mercurial
和我们本章中讨论的其他系统不一样，它能够处理合并，所以我们不需要做任何其他事情。

```shell
$ git merge origin/master
Auto-merging hello.c
Merge made by the 'recursive' strategy.
 hello.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git log --oneline --graph --decorate
*   0c64627 (HEAD, master) Merge remote-tracking branch 'origin/master'
|\
| * df85e87 (origin/master, origin/branches/default, origin/HEAD, refs/hg/origin/branches/default, refs/hg/origin/bookmarks/master) Add some documentation
* | ba04a2a Update makefile
* | d25d16f Goodbye
|/
* ac7955c Create a makefile
* 65bb417 Create a standard "hello, world" program
```

完美。
运行测试然后所有测试都通过了，所以我们准备将工作共享给团队的其他成员。

```shell
$ git push
To hg::/tmp/hello
   df85e87..0c64627  master -> master
```

就是这样！ 如果你现在查看一下 Mercurial
仓库，你会发现这样实现了我们所期望的：

```shell
$ hg log -G --style compact
o    5[tip]:4,2   dc8fa4f932b8   2014-08-14 19:33 -0700   ben
|\     Merge remote-tracking branch 'origin/master'
| |
| o  4   64f27bcefc35   2014-08-14 19:27 -0700   ben
| |    Update makefile
| |
| o  3:1   4256fc29598f   2014-08-14 19:27 -0700   ben
| |    Goodbye
| |
@ |  2   7db0b4848b3c   2014-08-14 19:30 -0700   ben
|/     Add some documentation
|
o  1   82e55d328c8c   2005-08-26 01:21 -0700   mpm
|    Create a makefile
|
o  0   0a04b987be5a   2005-08-26 01:20 -0700   mpm
     Create a standard "hello, world" program
```

序号 *2* 的变更集是由 Mercurial 生成的，序号 *3* 与序号 *4* 的变更集是由
git-remote-hg 生成的，通过 Git 推送上来的提交。

##### 分支与书签

Git 只有一种类型的分支：当提交生成时移动的一个引用。 在 Mercurial
中，这种类型的引用叫作 “bookmark”，它的行为非常类似于 Git 分支。

Mercurial 的 “branch” 概念则更重量级一些。 变更集生成时的分支会记录
*在变更集中*，意味着它会永远地存在于仓库历史中。 这个例子描述了一个在
`develop` 分支上的提交：

```shell
$ hg log -l 1
changeset:   6:8f65e5e02793
branch:      develop
tag:         tip
user:        Ben Straub <ben@straub.cc>
date:        Thu Aug 14 20:06:38 2014 -0700
summary:     More documentation
```

注意开头为 “branch” 的那行。 Git
无法真正地模拟这种行为（并且也不需要这样做；两种类型的分支都可以表达为
Git 的一个引用），但是 git-remote-hg 需要了解其中的区别，因为 Mercurial
关心。

创建 Mercurial 书签与创建 Git 分支一样容易。 在 Git 这边：

```shell
$ git checkout -b featureA
Switched to a new branch 'featureA'
$ git push origin featureA
To hg::/tmp/hello
 * [new branch]      featureA -> featureA
```

这就是所要做的全部。 在 Mercurial 这边，它看起来像这样：

```shell
$ hg bookmarks
   featureA                  5:bd5ac26f11f9
$ hg log --style compact -G
@  6[tip]   8f65e5e02793   2014-08-14 20:06 -0700   ben
|    More documentation
|
o    5[featureA]:4,2   bd5ac26f11f9   2014-08-14 20:02 -0700   ben
|\     Merge remote-tracking branch 'origin/master'
| |
| o  4   0434aaa6b91f   2014-08-14 20:01 -0700   ben
| |    update makefile
| |
| o  3:1   318914536c86   2014-08-14 20:00 -0700   ben
| |    goodbye
| |
o |  2   f098c7f45c4f   2014-08-14 20:01 -0700   ben
|/     Add some documentation
|
o  1   82e55d328c8c   2005-08-26 01:21 -0700   mpm
|    Create a makefile
|
o  0   0a04b987be5a   2005-08-26 01:20 -0700   mpm
     Create a standard "hello, world" program
```

注意在修订版本 5 上的新 `[featureA]` 标签。 在 Git 这边这些看起来像是
Git 分支，除了一点：不能从 Git 这边删除书签（这是远程助手的一个限制）。

你也可以工作在一个 “重量级” 的 Mercurial branch：只需要在 `branches`
命名空间内创建一个分支：

```shell
$ git checkout -b branches/permanent
Switched to a new branch 'branches/permanent'
$ vi Makefile
$ git commit -am 'A permanent change'
$ git push origin branches/permanent
To hg::/tmp/hello
 * [new branch]      branches/permanent -> branches/permanent
```

下面是 Mercurial 这边的样子：

```shell
$ hg branches
permanent                      7:a4529d07aad4
develop                        6:8f65e5e02793
default                        5:bd5ac26f11f9 (inactive)
$ hg log -G
o  changeset:   7:a4529d07aad4
|  branch:      permanent
|  tag:         tip
|  parent:      5:bd5ac26f11f9
|  user:        Ben Straub <ben@straub.cc>
|  date:        Thu Aug 14 20:21:09 2014 -0700
|  summary:     A permanent change
|
| @  changeset:   6:8f65e5e02793
|/   branch:      develop
|    user:        Ben Straub <ben@straub.cc>
|    date:        Thu Aug 14 20:06:38 2014 -0700
|    summary:     More documentation
|
o    changeset:   5:bd5ac26f11f9
|\   bookmark:    featureA
| |  parent:      4:0434aaa6b91f
| |  parent:      2:f098c7f45c4f
| |  user:        Ben Straub <ben@straub.cc>
| |  date:        Thu Aug 14 20:02:21 2014 -0700
| |  summary:     Merge remote-tracking branch 'origin/master'
[...]
```

分支名字 “permanent” 记录在序号 *7* 的变更集中。

在 Git
这边，对于其中任何一种风格的分支的工作都是相同的：仅仅是正常做的检出、提交、抓取、合并、拉取与推送。
还有需要知道的一件事情是 Mercurial 不支持重写历史，只允许添加历史。
下面是我们的 Mercurial 仓库在交互式的变基与强制推送后的样子：

```shell
$ hg log --style compact -G
o  10[tip]   99611176cbc9   2014-08-14 20:21 -0700   ben
|    A permanent change
|
o  9   f23e12f939c3   2014-08-14 20:01 -0700   ben
|    Add some documentation
|
o  8:1   c16971d33922   2014-08-14 20:00 -0700   ben
|    goodbye
|
| o  7:5   a4529d07aad4   2014-08-14 20:21 -0700   ben
| |    A permanent change
| |
| | @  6   8f65e5e02793   2014-08-14 20:06 -0700   ben
| |/     More documentation
| |
| o    5[featureA]:4,2   bd5ac26f11f9   2014-08-14 20:02 -0700   ben
| |\     Merge remote-tracking branch 'origin/master'
| | |
| | o  4   0434aaa6b91f   2014-08-14 20:01 -0700   ben
| | |    update makefile
| | |
+---o  3:1   318914536c86   2014-08-14 20:00 -0700   ben
| |      goodbye
| |
| o  2   f098c7f45c4f   2014-08-14 20:01 -0700   ben
|/     Add some documentation
|
o  1   82e55d328c8c   2005-08-26 01:21 -0700   mpm
|    Create a makefile
|
o  0   0a04b987be5a   2005-08-26 01:20 -0700   mpm
     Create a standard "hello, world" program
```

变更集 *8*、*9* 与 *10* 已经被创建出来并且属于 `permanent`
分支，但是旧的变更集依然在那里。 这会让使用 Mercurial
的团队成员非常困惑，所以要避免这种行为。

##### Mercurial 总结

Git 与 Mercurial 如此相似，以至于跨这两个系统进行工作十分流畅。
如果能注意避免改变在你机器上的历史（就像通常建议的那样），你甚至并不会察觉到另一端是
Mercurial。

Last updated 2024-03-09 10:37:42 +0800
