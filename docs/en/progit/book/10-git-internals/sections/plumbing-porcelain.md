### Plumbing and Porcelain

This book covers primarily how to use Git with 30 or so subcommands such
as `checkout`, `branch`, `remote`, and so on. But because Git was
initially a toolkit for a version control system rather than a full
user-friendly VCS, it has a number of subcommands that do low-level work
and were designed to be chained together UNIX-style or called from
scripts. These commands are generally referred to as Git’s “plumbing”
commands, while the more user-friendly commands are called “porcelain”
commands.

As you will have noticed by now, this book’s first nine chapters deal
almost exclusively with porcelain commands. But in this chapter, you’ll
be dealing mostly with the lower-level plumbing commands, because they
give you access to the inner workings of Git, and help demonstrate how
and why Git does what it does. Many of these commands aren’t meant to be
used manually on the command line, but rather to be used as building
blocks for new tools and custom scripts.

When you run `git init` in a new or existing directory, Git creates the
`.git` directory, which is where almost everything that Git stores and
manipulates is located. If you want to back up or clone your repository,
copying this single directory elsewhere gives you nearly everything you
need. This entire chapter basically deals with what you can see in this
directory. Here’s what a newly-initialized `.git` directory typically
looks like:

```shell
$ ls -F1
config
description
HEAD
hooks/
info/
objects/
refs/
```

Depending on your version of Git, you may see some additional content
there, but this is a fresh `git init` repository — it’s what you see by
default. The `description` file is used only by the GitWeb program, so
don’t worry about it. The `config` file contains your project-specific
configuration options, and the `info` directory keeps a global exclude
file for ignored patterns that you don’t want to track in a `.gitignore`
file. The `hooks` directory contains your client- or server-side hook
scripts, which are discussed in detail in
[ch08-customizing-git](ch08-customizing-git.md#git_hooks).

This leaves four important entries: the `HEAD` and (yet to be created)
`index` files, and the `objects` and `refs` directories. These are the
core parts of Git. The `objects` directory stores all the content for
your database, the `refs` directory stores pointers into commit objects
in that data (branches, tags, remotes and more), the `HEAD` file points
to the branch you currently have checked out, and the `index` file is
where Git stores your staging area information. You’ll now look at each
of these sections in detail to see how Git operates.

Last updated 2024-03-09 10:34:27 +0800
