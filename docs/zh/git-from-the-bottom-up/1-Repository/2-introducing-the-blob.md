# Blob介绍

现在基本情况已经介绍完毕，让我们进入一些实际示例。我将从创建一个样例 Git 存储库开始，并展示 Git 是如何在该存储库中自下而上地工作的。在阅读时，随时可以跟着操作：

```bash
$ mkdir sample; cd sample
$ echo 'Hello, world!' > greeting
```

在这里，我创建了一个名为“sample”的新文件系统目录，其中包含一个内容是乏味可预测的文件。我甚至还没有创建存储库，但我已经可以开始使用一些 Git 的命令来了解它将要做什么了。首先，我想知道 Git 将把我的问候文本存储在哪个哈希标识下：

```bash
$ git hash-object greeting
af5626b4a114abcb82d63db7c8082c3c4756e51b
```

如果你在你的系统上运行这个命令，你会得到相同的哈希标识。即使我们创建了两个不同的存储库（可能相隔甚远），我们存储库中的问候 blob 将具有相同的哈希标识。我甚至可以将你存储库中的提交拉到我的存储库中，Git 会意识到我们正在追踪相同的内容 —— 因此只会存储一份副本！相当酷。

接下来的步骤是初始化一个新存储库，并将文件提交到其中。我现在将一次性完成所有步骤，但稍后会回过头来逐步进行，以便你了解底层发生了什么：

```bash
$ git init
$ git add greeting
$ git commit -m "Added my greeting"
```

此时，我们的 blob 应该正如我们所期望的那样在系统中。为了方便起见，Git 仅需要足以在存储库中唯一标识它的哈希标识的位数。通常只需要六到七位数字就足够了：

```bash
$ git cat-file -t af5626b
blob
$ git cat-file blob af5626b
Hello, world!
```

就是这样！我甚至还没有查看包含它的提交，或者它在哪个树中，但仅基于内容，我就能假设它在那里，而它就在那里。无论存储库存活多长时间，或者其中的文件存储在何处，这些特定内容现在都被可验证地永久保存了。

这样，一个 Git blob 代表了 Git 中的基本数据单元。实际上，整个系统都是围绕着 blob 管理展开的。
