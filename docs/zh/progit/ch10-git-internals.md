## Git 内部原理

无论是从之前的章节直接跳到本章，还是读完了其余章节一直到这——你都将在本章见识到
Git 的内部工作原理和实现方式。 我们认为学习这部分内容对于理解 Git
的用途和强大至关重要。不过也有人认为这些内容对于初学者而言可能难以理解且过于复杂。
因此我们把这部分内容放在最后一章，在学习过程中可以先阅读这部分，也可以晚点阅读这部分，这取决于你自己。

无论如何，既然已经读到了这里，就让我们开始吧。
首先要弄明白一点，从根本上来讲 Git
是一个内容寻址（content-addressable）文件系统，并在此之上提供了一个版本控制系统的用户界面。
马上你就会学到这意味着什么。

早期的 Git（主要是 1.5
之前的版本）的用户界面要比现在复杂的多，因为它更侧重于作为一个文件系统，而不是一个打磨过的版本控制系统。
不时会有一些陈词滥调抱怨早期那个晦涩复杂的 Git
用户界面；不过最近几年来，它已经被改进到不输于任何其他版本控制系统地清晰易用了。

内容寻址文件系统层是一套相当酷的东西，所以在本章我们会先讲解这部分内容。随后我们会学习传输机制和版本库管理任务——你迟早会和它们打交道。

1.  [plumbing-porcelain](book/10-git-internals/sections/plumbing-porcelain.md)

2.  [objects](book/10-git-internals/sections/objects.md)

3.  [refs](book/10-git-internals/sections/refs.md)

4.  [packfiles](book/10-git-internals/sections/packfiles.md)

5.  [refspec](book/10-git-internals/sections/refspec.md)

6.  [transfer-protocols](book/10-git-internals/sections/transfer-protocols.md)

7.  [maintenance](book/10-git-internals/sections/maintenance.md)

8.  [environment](book/10-git-internals/sections/environment.md)

### 总结

现在，你应该相当了解 Git
在背后都做了些什么工作，并且在一定程度上也知道了 Git 是如何实现的。
本章讨论了很多底层命令，这些命令比我们在本书其余部分学到的高层命令来得更原始，也更简洁。
从底层了解 Git 的工作原理有助于更好地理解 Git
在内部是如何运作的，也方便你能够针对特定的工作流写出自己的工具和脚本。

作为一套内容寻址文件系统，Git
不仅仅是一个版本控制系统，它同时是一个非常强大且易用的工具。
我们希望你可以借助新学到的 Git
内部原理相关知识来实现出自己的应用，并且以更高级、更得心应手的方式来驾驭
Git。

Last updated 2024-03-09 10:37:59 +0800
