# 重置，还是不重置

在Git中，其中一个更难掌握的命令是 `reset`（重置），它似乎比其他命令更经常使人们感到困惑。这是可以理解的，因为它有潜力改变你的工作树和当前的 HEAD 引用。因此，我认为对这个命令进行一个快速回顾会很有用。

基本上，`reset` 是一个引用编辑器、索引编辑器和工作树编辑器。这在一定程度上使它变得如此令人困惑，因为它能够执行如此多的任务。让我们来研究一下这三种模式之间的区别，以及它们如何融入到Git提交模型中。
