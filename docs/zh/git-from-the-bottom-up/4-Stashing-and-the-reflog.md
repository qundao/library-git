# 贮藏和引用日志

到目前为止，我们描述了两种 blob 进入 Git 的方式：首先它们被创建在你的索引中，既没有父树也没有拥有的提交；然后它们被提交到仓库中，在那里它们作为叶子挂在该提交所持有的树上。但是，blob 还有另外两种方式可以存在于你的仓库中。

其中一种是 Git 的 `reflog`，一种记录你对仓库进行的每一次更改的元仓库，以提交的形式记录。这意味着当你从你的索引创建一个树并将其存储在一个提交下（这一切都是通过 `commit` 完成的）时，你也无意中将该提交添加到了 reflog（引用日志） 中，可以使用以下命令查看：

```bash
$ git reflog
5f1bc85...  HEAD@{0}: commit (initial): Initial commit
```

reflog 的美妙之处在于，它独立于你的仓库中的其他更改而存在。这意味着我可以将上述提交与我的仓库解除关联（使用 `reset`），但它仍然会被 reflog 引用 30 天，免受垃圾收集的影响。这给了我一个月的时间来恢复提交，如果我发现我真的需要它。

blob 可以存在的另一个地方，尽管间接地，就是在你的工作树中。我的意思是，假设你已经改变了一个名为 `foo.c` 的文件，但你还没有将这些更改添加到索引中。Git 可能没有为你创建一个 blob，但这些更改确实存在，这意味着内容存在——它只是存在于你的文件系统中，而不是 Git 的仓库中。该文件甚至有其自己的 SHA1 哈希标识，尽管实际上并不存在真正的 blob。你可以使用以下命令查看它：

```bash
$ git hash-object foo.c
<some hash id>
```

这对你有什么作用呢？嗯，如果你发现自己在你的工作树上进行修改，然后你度过了漫长的一天，一个好习惯就是贮藏（stash）起你的更改：

```bash
git stash
```

这将获取你目录中的所有内容——包括你的工作树和索引的状态——并在 Git 仓库中为它们创建 blob，一个用于保存这些 blob 的树，并创建一对用于保存工作树和索引的贮藏提交，并记录你进行贮藏的时间。

这是一个好的做法，因为，尽管第二天你只需用 `stash apply` 将你的更改重新取出，但你每天结束时都会有一个贮藏的所有更改的 reflog。以下是第二天回到工作时你将要执行的操作（这里的 WIP 意味着“进行中”）：

```bash
$ git stash list
stash@{0}: WIP on master: 5f1bc85...  Initial commit

$ git reflog show stash # same output, plus the stash commit's hash id 2add13e... stash@{0}: WIP on master: 5f1bc85... Initial commit

$ git stash apply
```

因为你的贮藏的工作树存储在一个提交下，所以你可以像对待任何其他分支一样使用它——随时！这意味着你可以查看日志，查看何时进行了贮藏，并从你贮藏时的任何过去的工作树中检出任何一个：

```bash
$ git stash list
stash@{0}: WIP on master: 73ab4c1...  Initial commit
...
stash@{32}: WIP on master: 5f1bc85...  Initial commit
$ git log stash@{32}  # 我是何时做的？
$ git show stash@{32}  # 展示我当时在做什么
$ git checkout -b temp stash@{32}  # 让我们看看那个旧的工作树！
```

这最后一个命令尤其强大：看哪，我现在正在玩弄一个一个月前的未提交的工作树。我甚至从未将这些文件添加到索引中；我只是在每天注销之前调用 `stash` 并在每天登录时使用 `stash apply`。

如果你想要清理贮藏列表——例如只保留最近 30 天的活动——不要使用 `stash clear`；而应该使用 `reflog expire` 命令：

```bash
$ git stash clear  # 不要！你将会丢失所有的历史记录
$ git reflog expire --expire=30.days refs/stash
<输出已经被保留的贮藏捆>
```

`stash` 的美妙之处在于，它让你对工作过程本身应用了不显眼的版本控制：即从一天到另一天的工作树的各个阶段。如果你喜欢，甚至可以定期使用 `stash`，例如使用以下 `snapshot` 脚本：

```bash
$ cat <<EOF > /usr/local/bin/git-snapshot
#!/bin/sh
git stash && git stash apply
EOF
$ chmod +x /usr/local/bin/git-snapshot
$ git-snapshot
```

你可以每小时从一个 `cron` 任务中运行它，同时每周或每月运行一次 `reflog expire` 命令。
