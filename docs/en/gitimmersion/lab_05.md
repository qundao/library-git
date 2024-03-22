# *lab 5* Making Changes

## Goals

- Learn how to monitor the state of the working directory

## Change the “Hello, World” program

It’s time to change our hello program to take an argument from the
command line. Change the file to be:

### *hello.rb*

``` file
puts "Hello, #{ARGV.first}!"
```

## Check the status

Now check the status of the working directory.

### **Execute:**

``` instructions
git status
```

You should see …

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

The first thing to notice is that git knows that the `hello.rb` file has
been modified, but git has not yet been notified of these changes.

Also notice that the status message gives you hints about what you need
to do next. If you want to add these changes to the repository, then use
the `git add` command. Otherwise the `git checkout` command can be used
to discard the changes.

## Up Next

Let’s stage the change.
