# 执行混合重置

如果你使用 `--mixed` 选项（或者根本不使用选项，因为这是默认值），重置将部分地恢复你的索引以及你的 HEAD 引用，使其与给定的提交匹配。与 `--soft` 的主要区别在于 `--soft` 仅更改了 HEAD 的含义，而不触及索引。

```bash
$ git add foo.c  # 将更改添加到索引作为一个新的 blob
$ git reset HEAD  # 删除索引中已暂存的任何更改
$ git add foo.c  # 犯了一个错误，将其重新添加回去
```