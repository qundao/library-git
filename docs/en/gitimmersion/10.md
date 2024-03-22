# *lab 10* History

## Goals

- Learn how to view the history of the project.

Getting a listing of what changes have been made is the function of the
`git log` command.

### **Execute:**

``` instructions
git log
```

You should see …

### **Output:**

``` sample
$ git log
commit e4e3645637546103e72f0deb9abdd22dd256601e
Author: Jim Weirich <jim (at) edgecase.com>
Date:   Sat Jun 10 03:49:13 2023 -0400

    Added a comment

commit a6b268ebc6a47068474bd6dfb638eb06896a6057
Author: Jim Weirich <jim (at) edgecase.com>
Date:   Sat Jun 10 03:49:13 2023 -0400

    Added a default value

commit 174dfabb62e6588c0e3c40867295da073204eb01
Author: Jim Weirich <jim (at) edgecase.com>
Date:   Sat Jun 10 03:49:13 2023 -0400

    Using ARGV

commit f7c41d3ce80ca44e2c586434cbf90fea3a9009a5
Author: Jim Weirich <jim (at) edgecase.com>
Date:   Sat Jun 10 03:49:13 2023 -0400

    First Commit
```

Here is a list of all four commits that we have made to the repository
so far.

## One Line Histories

You have a great deal of control over exactly what the `log` command
displays. I like the one line format:

### **Execute:**

``` instructions
git log --pretty=oneline
```

You should see …

### **Output:**

``` sample
$ git log --pretty=oneline
e4e3645637546103e72f0deb9abdd22dd256601e Added a comment
a6b268ebc6a47068474bd6dfb638eb06896a6057 Added a default value
174dfabb62e6588c0e3c40867295da073204eb01 Using ARGV
f7c41d3ce80ca44e2c586434cbf90fea3a9009a5 First Commit
```

## Controlling Which Entries are Displayed

There are a lot of options for selecting which entries are displayed in
the log. Play around with the following options:

``` instructions
git log --pretty=oneline --max-count=2
git log --pretty=oneline --since='5 minutes ago'
git log --pretty=oneline --until='5 minutes ago'
git log --pretty=oneline --author=<your name>
git log --pretty=oneline --all
```

See man git-log for all the details.

## Getting Fancy

Here’s what I use to review the changes made in the last week. I’ll add
`--author=jim` if I only want to see changes I made.

``` instructions
git log --all --pretty=format:'%h %cd %s (%an)' --since='7 days ago'
```

## The Ultimate Log Format

Over time, I’ve decided that I like the following log format for most of
my work.

### **Execute:**

``` instructions
git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
```

It looks like this:

### **Output:**

``` sample
$ git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
* e4e3645 2023-06-10 | Added a comment (HEAD -> main) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

Let’s look at it in detail:

- `--pretty="..."` defines the format of the output.
- `%h` is the abbreviated hash of the commit
- `%d` are any decorations on that commit (e.g. branch heads or tags)
- `%ad` is the author date
- `%s` is the comment
- `%an` is the author name
- `--graph` informs git to display the commit tree in an ASCII graph
  layout
- `--date=short` keeps the date format nice and short

This is a lot to type every time you want to see the log. Fortunately we
will learn about git aliases in the next lab.

## Other Tools

Both `gitx` (for Macs) and `gitk` (any platform) are useful in exploring
log history.
