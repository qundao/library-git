# *lab 8* Committing Changes

## Goals

- Learn how to commit changes to the repository

## Commit the change

Ok, enough about staging. Let’s commit what we have staged to the
repository.

When you used `git commit` previously to commit the initial version of
the `hello.rb` file to the repository, you included the `-m` flag that
gave a comment on the command line. The commit command will allow you to
interactively edit a comment for the commit. Let’s try that now.

If you omit the `-m` flag from the command line, git will pop you into
the editor of your choice. The editor is chosen from the following list
(in priority order):

- GIT_EDITOR environment variable
- core.editor configuration setting
- VISUAL environment variable
- EDITOR environment variable

I have the EDITOR variable set to `emacsclient`.

So commit now and check the status.

### **Execute:**

``` instructions
git commit
```

You should see the following in your editor:

### **Output:**

``` sample
|
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch main
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   modified:   hello.rb
#
```

On the first line, enter the comment: “Using ARGV”. Save the file and
exit the editor. You should see …

### **Output:**

``` sample
git commit
Waiting for Emacs...
[main 569aa96] Using ARGV
 1 files changed, 1 insertions(+), 1 deletions(-)
```

The “Waiting for Emacs…” line comes from the `emacsclient` program which
sends the file to a running emacs program and waits for the file to be
closed. The rest of the output is the standard commit messages.

## Check the status

Finally let’s check the status again.

### **Execute:**

``` instructions
git status
```

You should see …

### **Output:**

``` sample
$ git status
On branch main
nothing to commit, working tree clean
```

The working directory is clean and ready for you to continue.
