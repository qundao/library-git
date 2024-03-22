# *lab 14* Undoing Local Changes (before staging)

## Goals

- Learn how to revert changes in the working directory

## Checkout main

Make sure you are on the latest commit in main before proceeding.

### **Execute:**

``` instructions
git checkout main
```

## Change hello.rb

Sometimes you have modified a file in your local working directory and
you wish to just revert to what has already been committed. The checkout
command will handle that.

Change hello.rb to have a bad comment.

### *hello.rb*

``` file
# This is a bad comment.  We want to revert it.
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

## Check the Status

First, check the status of the working directory.

### **Execute:**

``` instructions
git status
```

### **Output:**

``` sample
$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   hello.rb

no changes added to commit (use "git add" and/or "git commit -a")
```

We see that the `hello.rb` file has been modified, but hasn’t been
staged yet.

## Revert the changes in the working directory

Use the `checkout` command to checkout the repository’s version of the
`hello.rb` file.

### **Execute:**

``` instructions
git checkout hello.rb
git status
cat hello.rb
```

### **Output:**

``` sample
$ git checkout hello.rb
Updated 1 path from the index
$ git status
On branch main
nothing to commit, working tree clean
$ cat hello.rb
# Default is "World"
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

The status command shows us that there are no outstanding changes in the
working directory. And the “bad comment” is no longer part of the file
contents.
