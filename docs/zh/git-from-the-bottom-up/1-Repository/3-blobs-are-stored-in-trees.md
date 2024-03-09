# 存储在树中的Blob

文件的内容存储在blob中，但这些blob相当简单。它们没有名称，没有结构 —— 毕竟它们只是“blob”。

为了使Git能够表示你的文件的结构和命名，它将blob作为叶子节点附加到树中。现在，我不能通过查看blob就发现它属于哪个树，因为它可能有许多许多的所有者。但是我知道它一定存在于我刚刚创建的提交所持有的树中：

```bash
$ git ls-tree HEAD
100644 blob af5626b4a114abcb82d63db7c8082c3c4756e51b greeting
```

就在那里！这个第一个提交将我的greeting文件添加到了存储库中。此提交包含一个Git树，其中有一个叶子：greeting内容的blob。

虽然我可以通过将HEAD传递给 `ls-tree` 来查看包含我的blob的树，但我还没有看到由该提交引用的底层树对象。以下是几个其他命令，以突出显示这种差异，并因此发现我的树：

```bash
$ git rev-parse HEAD
588483b99a46342501d99e3f10630cfc1219ea32 # 在你的系统上可能会有所不同

$ git cat-file -t HEAD
commit

$ git cat-file commit HEAD
tree 0563f77d884e4f79ce95117e2d686d7d6e282887
author John Wiegley <johnw@newartisans.com> 1209512110 -0400
committer John Wiegley <johnw@newartisans.com> 1209512110 -0400
Added my greeting
```

第一个命令将HEAD别名解码为其引用的提交，第二个命令验证其类型，而第三个命令显示由该提交持有的树的散列ID，以及提交对象中存储的其他信息。提交的散列ID对于我的存储库是唯一的 —— 因为它包含了我的姓名和我做出提交的日期 —— 但树的散列ID应该是共同的，因为它包含了相同名称下的相同blob。

让我们验证这确实是相同的树对象：

```bash
$ git ls-tree 0563f77
100644 blob af5626b4a114abcb82d63db7c8082c3c4756e51b greeting
```

就是这样：我的存储库包含一个提交，该提交引用了一个持有blob的树 —— 包含我要记录的内容的blob。还有一个命令可以运行来验证这一点：

```bash
$ find .git/objects -type f | sort
.git/objects/05/63f77d884e4f79ce95117e2d686d7d6e282887
.git/objects/58/8483b99a46342501d99e3f10630cfc1219ea32
.git/objects/af/5626b4a114abcb82d63db7c8082c3c4756e51b
```

从此输出中，我看到整个存储库包含三个对象，每个对象的散列ID都出现在前面的示例中。让我们最后再看一下这些对象的类型，以满足好奇心：

```bash
   $ git cat-file -t 588483b99a46342501d99e3f10630cfc1219ea32
   commit
   $ git cat-file -t 0563f77d884e4f79ce95117e2d686d7d6e282887
   tree
   $ git cat-file -t af5626b4a114abcb82d63db7c8082c3c4756e51b
   blob
```

此时我可以使用show命令查看每个对象的简洁内容，但我将把这留给读者作为练习。
