## 演示：观察命令的效果

以下内容将带您浏览对存储库的更改，以便您可以实时查看命令的效果，类似于 [基于D3的Git概念图解](http://onlywei.github.io/explain-git-with-d3/#) 以图形方式模拟它们。希望您会觉得这个内容有用。

首先创建一个存储库：

```shell
$ git init foo
$ cd foo
$ echo 1 > myfile
$ git add myfile
$ git commit -m "version 1"
```

现在，定义以下函数来帮助我们显示信息：

```shell
show_status() {
  echo "HEAD:     $(git cat-file -p HEAD:myfile)"
  echo "Stage:    $(git cat-file -p :myfile)"
  echo "Worktree: $(cat myfile)"
}

initial_setup() {
  echo 3 > myfile
  git add myfile
  echo 4 > myfile
  show_status
}
```

最初，一切都是版本 1。

```shell
$ show_status
HEAD:     1
Stage:    1
Worktree: 1
```

当我们添加和提交时，我们可以观察状态的变化。

```shell
$ echo 2 > myfile
$ show_status
HEAD:     1
Stage:    1
Worktree: 2
$ git add myfile
$ show_status
HEAD:     1
Stage:    2
Worktree: 2
$ git commit -m "version 2"
[main 4156116] version 2
 1 file changed, 1 insertion(+), 1 deletion(-)
$ show_status
HEAD:     2
Stage:    2
Worktree: 2
```

现在，让我们创建一个初始状态，其中这三者都不相同。

```shell
$ initial_setup
HEAD:     2
Stage:    3
Worktree: 4
```

让我们观察每个命令的作用。您将看到它们与上面的图表相匹配。

`git reset -- myfile` 将从 HEAD 复制到暂存区：

```shell
$ initial_setup
HEAD:     2
Stage:    3
Worktree: 4
$ git reset -- myfile
Unstaged changes after reset:
M   myfile
$ show_status
HEAD:     2
Stage:    2
Worktree: 4
```

`git checkout -- myfile` 将从暂存区复制到工作区：

```shell
$ initial_setup
HEAD:     2
Stage:    3
Worktree: 4
$ git checkout -- myfile
$ show_status
HEAD:     2
Stage:    3
Worktree: 3
```

`git checkout HEAD -- myfile` 将从 HEAD 复制到暂存区和工作区：

```shell
$ initial_setup
HEAD:     2
Stage:    3
Worktree: 4
$ git checkout HEAD -- myfile
$ show_status
HEAD:     2
Stage:    2
Worktree: 2
```

`git commit myfile` 将从工作区复制到暂存区和 HEAD：

```shell
$ initial_setup
HEAD:     2
Stage:    3
Worktree: 4
$ git commit myfile -m "version 4"
[main 679ff51] version 4
 1 file changed, 1 insertion(+), 1 deletion(-)
$ show_status
HEAD:     4
Stage:    4
Worktree: 4
```
