## Git 分支

几乎所有的版本控制系统都以某种形式支持分支。
使用分支意味着你可以把你的工作从开发主线上分离开来，以免影响开发主线。
在很多版本控制系统中，这是一个略微低效的过程——常常需要完全创建一个源代码目录的副本。对于大项目来说，这样的过程会耗费很多时间。

有人把 Git 的分支模型称为它的“必杀技特性”，也正因为这一特性，使得 Git
从众多版本控制系统中脱颖而出。 为何 Git 的分支模型如此出众呢？ Git
处理分支的方式可谓是难以置信的轻量，创建新分支这一操作几乎能在瞬间完成，并且在不同分支之间的切换操作也是一样便捷。
与许多其它版本控制系统不同，Git
鼓励在工作流程中频繁地使用分支与合并，哪怕一天之内进行许多次。
理解和精通这一特性，你便会意识到 Git
是如此的强大而又独特，并且从此真正改变你的开发方式。

1.  [nutshell](book/03-git-branching/sections/nutshell.md)

2.  [basic-branching-and-merging](book/03-git-branching/sections/basic-branching-and-merging.md)

3.  [branch-management](book/03-git-branching/sections/branch-management.md)

4.  [workflows](book/03-git-branching/sections/workflows.md)

5.  [remote-branches](book/03-git-branching/sections/remote-branches.md)

6.  [rebasing](book/03-git-branching/sections/rebasing.md)

### 总结

我们已经讲完了 Git 分支与合并的基础知识。
你现在应该能自如地创建并切换至新分支、在不同分支之间切换以及合并本地分支。
你现在应该也能通过推送你的分支至共享服务以分享它们、使用共享分支与他人协作以及在共享之前使用变基操作合并你的分支。
下一章，我们将要讲到，如果你想要运行自己的 Git
仓库托管服务器，你需要知道些什么。

Last updated 2024-03-09 10:37:57 +0800
