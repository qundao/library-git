# *lab 11* Aliases

## Goals

- Learn how to setup aliases and shortcuts for git commands

## Common Aliases

`git status`, `git add`, `git commit`, and `git checkout` are such
common commands that it is useful to have abbreviations for them.

Add the following to the .gitconfig file in your \$HOME directory.

### *.gitconfig*

``` file
[alias]
  co = checkout
  ci = commit
  st = status
  br = branch
  hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
  type = cat-file -t
  dump = cat-file -p
```

We’ve covered the commit and status commands already. And we just
covered the `log` command in the previous lab. The `checkout` command
will be coming up soon.

With these aliases defined in the `.gitconfig` file you can type
`git co` wherever you used to have to type `git checkout`. Likewise with
`git st` for `git status` and `git ci` for `git commit`. And best of
all, `git hist` will allow you to avoid the really long `log` command.

Go ahead and give the new commands a try.

## Define the `hist` alias in your `.gitconfig` file

For the most part, I will continue to type out the full command in these
instructions. The only exception is that I will use the `hist` alias
defined above anytime we need to see the git log output. Make sure you
have a `hist` alias setup in your `.gitconfig` file before continuing if
you wish to follow along.

## `Type` and `Dump`

We’ve added a few aliases for commands we haven’t covered yet. The
`git branch` command will be coming up soon. And the `git cat-file`
command is useful for exploring git, which we will see in a little
while.

## Shell Aliases (Optional)

**Note:** This section is for folks running a posix-like shell. Windows
users and other non-posix shell users can feel free to skip to the next
lab.

If your shell supports aliases or shortcuts, then you can add aliases at
that level too. Here are the ones I use:

### *.profile*

``` file
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '
```

The `gco` abbreviation for `git checkout` is particularly nice. It
allows me to type:

``` instructions
gco <branch>
```

to checkout a particular branch.

And yes, I do mistype `git` as `get` or `got` often enough to create
aliases for them.
