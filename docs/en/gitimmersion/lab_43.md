# *lab 43* Merging Pulled Changes

## Goals

- Learn to get the pulled changes into the current branch and working
  directory.

## Merge the fetched changes into local main

### **Execute:**

``` instructions
git merge origin/main
```

### **Output:**

``` sample
$ git merge origin/main
Updating 5f626c6..5e2d55e
Fast-forward
 README | 1 +
 1 file changed, 1 insertion(+)
```

## Check the README again

We should see the changes now.

### **Execute:**

``` instructions
cat README
```

### **Output:**

``` sample
$ cat README
This is the Hello World example from the git tutorial.
(changed in original)
```

There are the changes. Even though “git fetch” does not merge the
changes, we can still manually merge the changes from the remote
repository.

## Up Next

Next let’s take a look at combining the fetch & merge process into a
single command.
