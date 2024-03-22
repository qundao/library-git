# *lab 15* Undoing Staged Changes (before committing)

## Goals

- Learn how to revert changes that have been staged

## Change the file and stage the change

Modify the `hello.rb` file to have a bad comment

### *hello.rb*

``` file
# This is an unwanted but staged comment
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

And then go ahead and stage it.

### **Execute:**

``` instructions
git add hello.rb
```

## Check the Status

Check the status of your unwanted change.

### **Execute:**

``` instructions
git status
```

### **Output:**

``` sample
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    modified:   hello.rb
```

The status output shows that the change has been staged and is ready to
be committed.

## Reset the Staging Area

The `reset` command resets the staging area to be whatever is in HEAD.
This clears the staging area of the change we just staged.

### **Execute:**

``` instructions
git reset HEAD hello.rb
```

### **Output:**

``` sample
$ git reset HEAD hello.rb
Unstaged changes after reset:
M   hello.rb
```

The `reset` command (by default) doesn’t change the working directory.
So the working directory still has the unwanted comment in it. We can
use the `checkout` command of the previous lab to remove the unwanted
change from the working directory.

**Note**: You could also have used the `git restore` command to restore
just the single file.

## Checkout the Committed Version

### **Execute:**

``` instructions
git checkout hello.rb
git status
```

### **Output:**

``` sample
$ git status
On branch main
nothing to commit, working tree clean
```

And our working directory is clean once again.
