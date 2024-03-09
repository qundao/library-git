# 树是如何创建的

每个提交都包含一个树，但树是如何生成的呢？我们知道 blob 是通过将文件内容填充到 blob 中而创建的 —— 而且树拥有 blob —— 但我们还没有看到是如何创建持有 blob 的树，以及如何将该树链接到其父提交的。

让我们再次从头开始一个新的示例存储库，但这次是手动进行，这样你就可以对底层发生的事情有一个清晰的了解：

```bash
$ rm -fr greeting .git
$ echo 'Hello, world!' > greeting
$ git init
$ git add greeting
```

一切都始于你首次将文件添加到索引中。现在，让我们只说索引是你用来最初将文件转换为 blob 的工具。当我添加文件 `greeting` 时，我的存储库发生了变化。我还不能将这个变化视为提交，但下面是一种方法，可以告诉我发生了什么：

```bash
$ git log # 这将失败，因为没有提交！
fatal: bad default revision 'HEAD'
$ git ls-files --stage # 列出索引引用的 blob
100644 af5626b4a114abcb82d63db7c8082c3c4756e51b 0 greeting
```

这是什么？我还没有向存储库提交任何内容，但是已经存在了一个对象。它具有我开始整个过程的相同散列 ID，所以我知道它代表了我的 `greeting` 文件的内容。此时，我可以在散列 ID 上使用 `cat-file -t` 命令，我会看到它是一个 blob。事实上，这正是我创建这个示例存储库时第一次得到的 blob。同样的文件将始终生成相同的 blob（以防我还没有强调到）。

这个 blob 还没有被树引用，也没有提交。目前，它仅被一个名为 `.git/index` 的文件引用，该文件引用了构成当前索引的 blob 和树。现在，让我们在仓库中创建一个树，让我们的 blob 悬挂在上面：

```bash
$ git write-tree # 记录索引的内容到一个树中
0563f77d884e4f79ce95117e2d686d7d6e282887
```

这个数字应该也很熟悉：一个包含相同 blob（和子树）的树将始终具有相同的散列 ID。我还没有提交对象，但现在存储库中有一个树对象，它持有这个 blob。低级别的 `write-tree` 命令的目的是将索引的内容放入新的树中，以便创建提交。

我可以直接使用这个树手动创建一个新的提交对象，这正是 `commit-tree` 命令所做的：

```bash
$ echo "Initial commit" | git commit-tree 0563f77
5f1bc85745dcccce6121494fdd37658cb4ad441f
```

原始的 `commit-tree` 命令接受一个树的散列 ID，并创建一个提交对象来保存它。如果我希望提交具有父提交，我将不得不使用 `-p` 选项显式地指定父提交的散列 ID。此外，在这里请注意，散列 ID 与将出现在你系统上的不同：这是因为我的提交对象引用了我的姓名，以及我创建提交的日期，而这两个细节将与你的不同。

但我们的工作还没有完成，因为我还没有将提交注册为分支的新头：

```bash
$ echo 5f1bc85745dcccce6121494fdd37658cb4ad441f > .git/refs/heads/master
```

此命令告诉 Git 分支名“master”现在应该指向我们最新的提交。另一个更安全的方法是使用 `update-ref` 命令：

```bash
$ git update-ref refs/heads/master 5f1bc857
```

创建 `master` 后，我们必须将工作树与其关联起来。通常，当你检出一个分支时，这会自动完成：

```bash
$ git symbolic-ref HEAD refs/heads/master
```

这个命令将 HEAD 符号地与主分支关联起来。这是重要的，因为从现在开始，工作树中的任何将来的提交都将自动更新 `refs/heads/master` 的值。

很难相信这么简单，但是是的，我现在可以使用 `log` 来查看我新创建的提交了：

```bash
$ git log
commit 5f1bc85745dcccce6121494fdd37658cb4ad441f
Author: John Wiegley <johnw@newartisans.com>
Date:   Mon Apr 14 11:14:58 2008 -0400
        Initial commit
```

一个旁注：如果我没有将 `refs/heads/master` 设置为指向新提交，它将被视为“不可达”，因为目前没有任何东西引用它，也不是可达提交的父提交。在这种情况下，提交对象在某个时候将从存储库中删除，以及其树和所有 blob。这是由一个称为 `gc` 的命令自动完成的，你很少需要手动使用它。通过将提交链接到 `refs/heads` 中的名称，如上所示，它变成了可达的提交，从现在开始确保它一直保留在那里。
