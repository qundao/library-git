# *lab 17* Removing Commits from a Branch

## Goals

- Learn how to remove the most recent commits from a branch

The `revert` command of the previous section is a powerful command that
lets us undo the effects of any commit in the repository. However, both
the original commit and the “undoing” commit are visible in the branch
history (using the `git log` command).

Often we make a commit and immediately realize that it was a mistake. It
would be nice to have a “take back” command that would allow us to
pretend that the incorrect commit never happened. The “take back”
command would even prevent the bad commit from showing up the `git log`
history. It would be as if the bad commit never happened.

## The `reset` command

We’ve already seen the `reset` command and have used it to set the
staging area to be consistent with a given commit (we used the HEAD
commit in our previous lab).

When given a commit reference (i.e. a hash, branch or tag name), the
`reset` command will …

1.  Rewrite the current branch to point to the specified commit
2.  Optionally reset the staging area to match the specified commit
3.  Optionally reset the working directory to match the specified commit

## Check Our History

Let’s do a quick check of our commit history.

### **Execute:**

``` instructions
git hist
```

### **Output:**

``` sample
$ git hist
* 8b71812 2023-06-10 | Revert "Oops, we didn't want this commit" (HEAD -> main) [Jim Weirich]
* 146fb71 2023-06-10 | Oops, we didn't want this commit [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

We see that we have an “Oops” commit and a “Revert Oops” commit as the
last two commits made in this branch. Let’s remove them using reset.

## First, Mark this Branch

But before we remove the commits, let’s mark the latest commit with a
tag so we can find it again.

### **Execute:**

``` instructions
git tag oops
```

## Reset to Before Oops

Looking at the log history (above), we see that the commit tagged ‘v1’
is the commit right before the bad commit. Let’s reset the branch to
that point. Since that branch is tagged, we can use the tag name in the
reset command (if it wasn’t tagged, we could just use the hash value).

### **Execute:**

``` instructions
git reset --hard v1
git hist
```

### **Output:**

``` sample
$ git reset --hard v1
HEAD is now at e4e3645 Added a comment
$ git hist
* e4e3645 2023-06-10 | Added a comment (HEAD -> main, tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

Our main branch now points to the v1 commit and the Oops commit and the
Revert Oops commit are no longer in the branch. The `--hard` parameter
indicates that the working directory should be updated to be consistent
with the new branch head.

## Nothing is Ever Lost

But what happened to the bad commits? It turns out that the commits are
still in the repository. In fact, we can still reference them. Remember
that at the beginning of this lab we tagged the reverting commit with
the tag “oops”. Let’s look at *all* the commits.

### **Execute:**

``` instructions
git hist --all
```

### **Output:**

``` sample
$ git hist --all
* 8b71812 2023-06-10 | Revert "Oops, we didn't want this commit" (tag: oops) [Jim Weirich]
* 146fb71 2023-06-10 | Oops, we didn't want this commit [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (HEAD -> main, tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

Here we see that the bad commits haven’t disappeared. They are still in
the repository. It’s just that they are no longer listed in the main
branch. If we hadn’t tagged them, they would still be in the repository,
but there would be no way to reference them other than using their hash
names. Commits that are unreferenced remain in the repository until the
system runs the garbage collection software.

## Dangers of Reset

Resets on local branches are generally safe. Any “accidents” can usually
be recovered from by just resetting again with the desired commit.

However, if the branch is shared on remote repositories, resetting can
confuse other users sharing the branch.
