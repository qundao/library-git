# 8. 提交修改

## 目标

- 学习如何提交修改到仓库。

### 提交修改

关于暂存谈得够多了。让我们提交已暂存的内容到仓库。

你先前使用 `git commit` 命令提交 `hello.rb`
文件的初始化版本到仓库时，你在命令行上的 `-m` 选项可以包含注释。 commit
命令将允许你交互式地编辑提交的注释。现在让我们试试看。

如果你在命令行忽略 `-m` 选项，那么 Git
将带你到所选的编辑器中。编辑器按以下列表选择（使用优先级顺序）：

- `GIT_EDITOR` 环境变量
- `core.editor` 配置设置
- `VISUAL` 环境变量
- `EDITOR` 环境变量

我已将 `EDITOR` 变量设置为 `emacsclient`。

那么，现在提交并检查状态。

``` shell
$ git commit
```

你应该在编辑器中看到下面的内容：

``` shell
|
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   modified:   hello.rb
#
```

在第一行，输入注释：“Using ARGV”。保存文件，并退出编辑器。你可以看到：

``` shell
git commit
Waiting for Emacs...
[master 569aa96] Using ARGV
1 files changed, 1 insertions(+), 1 deletions(-)
```

“Waiting for Emacs...” 来自发送文件到正在运行的 Emacs 程序
`emacsclient`，并等候关闭文件。 其余的输出是标准的提交信息。

### 检查状态

最后，让我们再检查下状态。

``` shell
$ git status
```

你可以看到：

``` shell
$ git status
On branch master
nothing to commit, working tree clean
```

工作目录是干净的，且准备让你继续。
