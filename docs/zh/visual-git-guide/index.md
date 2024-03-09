---
lang: zh-CN
title: 图解Git
---

# 图解Git

此页图解git中的最常用命令。如果你稍微理解git的工作原理，这篇文章能够让你理解的更透彻。
如果你想知道这个站点怎样产生，请前往[GitHub
repository](http://github.com/MarkLodato/visual-git-guide)。

## 目录

1.  [基本用法](1-basic-usage.md)
2.  [约定](2-conventions.md)
3.  [命令详解](3-commands.md)
    1.  [Diff](3-commands.md#diff)
    2.  [Commit](3-commands.md#commit)
    3.  [Checkout](3-commands.md#checkout)
    4.  [Committing with a Detached HEAD](3-commands.md#detached)
    5.  [Reset](3-commands.md#reset)
    6.  [Merge](3-commands.md#merge)
    7.  [Cherry Pick](3-commands.md#cherry-pick)
    8.  [Rebase](3-commands.md#rebase)
4.  [技术说明](4-technical-notes.md)
5.  [演示：观察命令效果](5-walkthrough.md)

---

- 版权 © 2010, [Mark Lodato](mailto:lodatom@gmail.com).
- 日语译文 © 2010, [Kazu Yamamoto](http://github.com/kazu-yamamoto).
- 韩语（朝鲜语）译文 © 2011, [Sean Lee](mailto:sean@weaveus.com).
- 俄语译文 © 2012, [Alex Sychev](mailto:alex@sychev.com).
- 法语译文 © 2012, [Michel Lefranc](mailto:michel.lefranc@gmail.com).
- 简体中文译文 © 2012, [wych](mailto:ellrywych@gmail.com).
- 西班牙语译文 © 2012, [Lucas Videla](http://www.delucas.com.ar).
- 意大利语译文 © 2012, [Daniel Londero](mailto:daniel.londero@gmail.com).
- 德语译文 © 2013, [Martin Funk](mailto:mafulafunk@gmail.com).
- 斯洛伐克语译文 © 2013, [Ľudovít Lučenič](https://github.com/llucenic).
- 葡萄牙语译文 © 2014, [Gustavo de Oliveira](mailto:goliveira5d@gmail.com).
- 繁体中文译文 © 2015, [Peter Dave Hello](https://github.com/PeterDaveHello).
- 波兰语译文 © 2017, [Emil Wypych](mailto:wypychemil@gmail.com).

[![](../../images/visual-git-guide/https://i.creativecommons.org/l/by-nc-sa/3.0/us/80x15.png)](https://creativecommons.org/licenses/by-nc-sa/3.0/us/)
本著作系采用[创用CC 姓名标示-非商业性-相同方式分享3.0
美国授权条款](https://creativecommons.org/licenses/by-nc-sa/3.0/us/)授权。
