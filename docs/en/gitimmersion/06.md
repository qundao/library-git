# *lab 6* Staging Changes

## Goals

- Learn how to stage changes for later commits

## Add Changes

Now tell git to stage the changes. Check the status

### **Execute:**

``` instructions
git add hello.rb
git status
```

You should see …

### **Output:**

``` sample
$ git add hello.rb
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    modified:   hello.rb
```

The change to the `hello.rb` file has been staged. This means that git
now knows about the change, but the change hasn’t been *permanently*
recorded in the repository yet. The next commit operation will include
the staged changes.

If you decide you *don’t* want to commit that change after all, the
status command reminds you that the `git restore` command can be used to
unstage that change.
