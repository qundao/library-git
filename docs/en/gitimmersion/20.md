# *lab 20* Moving Files

## Goals

- Learn how to move a file within a repository.

## Move the hello.rb file into a lib directory.

We are now going to build up the structure of our little repository.
Let’s move the program into a lib directory.

### **Execute:**

``` instructions
mkdir lib
git mv hello.rb lib
git status
```

### **Output:**

``` sample
$ mkdir lib
$ git mv hello.rb lib
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    renamed:    hello.rb -> lib/hello.rb
```

By using git to do the move, we inform git of 2 things

1.  That the file `hello.rb` has been deleted.
2.  The file `lib/hello.rb` has been created.

Both of these bits of information are immediately staged and ready to be
committed. The git status command reports that the file has been moved.

## Another way of moving files

One of the nice things about git is that you can forget about source
control until the point you are ready to start committing code. What
would happen if we used the operating system command to move the file
instead of the git command?

It turns out the following set of commands is identical to what we just
did. It’s a bit more work, but the result is the same.

We could have done:

``` instructions
mkdir lib
mv hello.rb lib
git add lib/hello.rb
git rm hello.rb
```

## Commit the new directory

Let’s commit this move.

### **Execute:**

``` instructions
git commit -m "Moved hello.rb to lib"
```
