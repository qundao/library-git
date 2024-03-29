### 分支管理

现在已经创建、合并、删除了一些分支，让我们看看一些常用的分支管理工具。

`git branch` 命令不只是可以创建与删除分支。
如果不加任何参数运行它，会得到当前所有分支的一个列表：

```shell
$ git branch
  iss53
* master
  testing
```

注意 `master` 分支前的 `*`
字符：它代表现在检出的那一个分支（也就是说，当前 `HEAD`
指针所指向的分支）。 这意味着如果在这时候提交，`master`
分支将会随着新的工作向前移动。
如果需要查看每一个分支的最后一次提交，可以运行 `git branch -v` 命令：

```shell
$ git branch -v
  iss53   93b412c fix javascript issue
* master  7a98805 Merge branch 'iss53'
  testing 782fd34 add scott to the author list in the readmes
```

`--merged` 与 `--no-merged`
这两个有用的选项可以过滤这个列表中已经合并或尚未合并到当前分支的分支。
如果要查看哪些分支已经合并到当前分支，可以运行 `git branch --merged`：

```shell
$ git branch --merged
  iss53
* master
```

因为之前已经合并了 `iss53` 分支，所以现在看到它在列表中。
在这个列表中分支名字前没有 `*` 号的分支通常可以使用 `git branch -d`
删除掉；你已经将它们的工作整合到了另一个分支，所以并不会失去任何东西。

查看所有包含未合并工作的分支，可以运行 `git branch --no-merged`：

```shell
$ git branch --no-merged
  testing
```

这里显示了其他分支。 因为它包含了还未合并的工作，尝试使用
`git branch -d` 命令删除它时会失败：

```shell
$ git branch -d testing
error: The branch 'testing' is not fully merged.
If you are sure you want to delete it, run 'git branch -D testing'.
```

如果真的想要删除分支并丢掉那些工作，如同帮助信息里所指出的，可以使用
`-D` 选项强制删除它。

[TABLE]

Last updated 2024-03-09 10:37:26 +0800
