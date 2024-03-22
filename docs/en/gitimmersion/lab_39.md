# *lab 39* What is Origin?

## Goals

- Learn about naming remote repositories.

### **Execute:**

``` instructions
git remote
```

### **Output:**

``` sample
$ git remote
origin
```

We see that the cloned repository knows about a remote repository named
origin. Let’s see if we can get more information about origin:

### **Execute:**

``` instructions
git remote show origin
```

### **Output:**

``` sample
$ git remote show origin
warning: more than one branch.main.remote
* remote origin
  Fetch URL: /Users/jim/Downloads/git_tutorial/work/hello
  Push  URL: /Users/jim/Downloads/git_tutorial/work/hello
  HEAD branch: main
  Remote branches:
    greet tracked
    main  tracked
  Local branches configured for 'git pull':
    main   merges with remote main
              and with remote main
    master merges with remote master
  Local ref configured for 'git push':
    main pushes to main (up to date)
```

Now we see that the remote repository “origin” is simply the original
**hello** repository. Remote repositories typically live on a separate
machine, possibly a centralized server. As we can see here, however,
they can just as well point to a repository on the same machine. There
is nothing particularly special about the name “origin”, however the
convention is to use the name “origin” for the primary centralized
repository (if there is one).
