# *lab 9* Changes, not Files

## Goals

- Learn that git works with changes, not files.

Most source control systems work with files. You add a file to source
control and the system will track changes to the file from that point
on.

Git focuses on the changes to a file rather than the file itself. When
you say `git add file`, you are not telling git to add the file to the
repository. Rather you are saying that git should make note of the
current state of that file to be committed later.

We will attempt to explore that difference in this lab.

## First Change: Allow a default name

Change the “Hello, World” program to have a default value if a command
line argument is not supplied.

### *hello.rb*

``` file
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

## Add this Change

Now add this change to the git’s staging area.

### **Execute:**

``` instructions
git add hello.rb
```

## Second change: Add a comment

Now add a comment to the “Hello, World” program.

### *hello.rb*

``` file
# Default is "World"
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

## Check the current status

### **Execute:**

``` instructions
git status
```

You should see …

### **Output:**

``` sample
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    modified:   hello.rb

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   hello.rb
```

Notice how `hello.rb` is listed twice in the status. The first change
(adding a default) is staged and is ready to be committed. The second
change (adding a comment) is unstaged. If you were to commit right now,
the comment would not be saved in the repository.

Let’s try that.

## Committing

Commit the staged change (the default value), and then recheck the
status.

### **Execute:**

``` instructions
git commit -m "Added a default value"
git status
```

You should see …

### **Output:**

``` sample
$ git commit -m "Added a default value"
[main a6b268e] Added a default value
 1 file changed, 3 insertions(+), 1 deletion(-)
$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   hello.rb

no changes added to commit (use "git add" and/or "git commit -a")
```

The status command is telling you that `hello.rb` has unrecorded
changes, but is no longer in the staging area.

## Add the Second Change

Now add the second change to staging area, then run git status.

### **Execute:**

``` instructions
git add .
git status
```

**Note:** We used the current directory (‘.’) as the file to add. This
is a really convenient shortcut for adding in all the changes to the
files in the current directory and below. But since it adds everything,
it is a *really* good idea to check the status before doing an `add .`,
just to make sure you don’t add any file that is not intended.

I wanted you to see the “add .” trick, but we will continue to add
explicit files in the rest of this tutorial just to be safe.

You should see …

### **Output:**

``` sample
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    modified:   hello.rb
```

Now the second change has been staged and is ready to commit.

## Commit the Second Change

### **Execute:**

``` instructions
git commit -m "Added a comment"
```
