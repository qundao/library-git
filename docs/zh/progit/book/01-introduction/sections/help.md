### 获取帮助

若你使用 Git 时需要获取帮助，有三种等价的方法可以找到 Git
命令的综合手册（manpage）：

```shell
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```

例如，要想获得 `git config` 命令的手册，执行

```shell
$ git help config
```

这些命令很棒，因为你随时随地可以使用而无需联网。
如果你觉得手册或者本书的内容还不够用，你可以尝试在 Freenode IRC 服务器
[https://freenode.net](https://freenode.net) 上的 `#git` 或 `#github`
频道寻求帮助。 这些频道经常有上百人在线，他们都精通 Git 并且乐于助人。

此外，如果你不需要全面的手册，只需要可用选项的快速参考，那么可以用 `-h`
选项获得更简明的 \`\`help'' 输出：

```shell
$ git add -h
usage: git add [<options>] [--] <pathspec>...

    -n, --dry-run         dry run
    -v, --verbose         be verbose

    -i, --interactive     interactive picking
    -p, --patch           select hunks interactively
    -e, --edit            edit current diff and apply
    -f, --force           allow adding otherwise ignored files
    -u, --update          update tracked files
    --renormalize         renormalize EOL of tracked files (implies -u)
    -N, --intent-to-add   record only the fact that the path will be added later
    -A, --all             add changes from all tracked and untracked files
    --ignore-removal      ignore paths removed in the working tree (same as --no-all)
    --refresh             don't add, only refresh the index
    --ignore-errors       just skip files which cannot be added because of errors
    --ignore-missing      check if - even missing - files are ignored in dry run
    --chmod (+|-)x        override the executable bit of the listed files
```

Last updated 2024-03-09 10:37:21 +0800
