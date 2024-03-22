# *lab 40* Remote Branches

## Goals

- Learn about local VS remote branches

Let’s look at the branches available in our cloned repository.

### **Execute:**

``` instructions
git branch
```

### **Output:**

``` sample
$ git branch
* main
```

That’s it, only the main branch is listed. Where is the greet branch?
The **git** **branch** command only lists the local branches by default.

## List Remote Branches

Try this to see all the branches:

### **Execute:**

``` instructions
git branch -a
```

### **Output:**

``` sample
$ git branch -a
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/greet
  remotes/origin/main
```

Git has all the commits from the original repository, but branches in
the remote repository are not treated as local branches here. If we want
our own **greet** branch, we need to create it ourselves. We will see
how to do that in a minute.
