# *lab 45* Adding a Tracking Branch

## Goals

- Learn how to add a local branch that tracks a remote branch.

The branches starting with remotes/origin are branches from the original
repo. Notice that you don’t have a branch called greet anymore, but it
knows that the original repo had a greet branch.

## Add a local branch that tracks a remote branch.

### **Execute:**

``` instructions
git branch --track greet origin/greet
git branch -a
git hist --max-count=2
```

### **Output:**

``` sample
$ git branch --track greet origin/greet
Branch 'greet' set up to track remote branch 'greet' from 'origin'.
$ git branch -a
  greet
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/greet
  remotes/origin/main
$ git hist --max-count=2
* 5e2d55e 2023-06-10 | Changed README in original repo (HEAD -> main, origin/main, origin/HEAD) [Jim Weirich]
* 5f626c6 2023-06-10 | Updated Rakefile (origin/greet, greet) [Jim Weirich]
```

We can now see the greet branch in the branch list and in the log.
