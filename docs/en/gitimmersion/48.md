# *lab 48* Pushing a Change

## Goals

- Learn how to push a change to a remote repository.

Since bare repositories are usually shared on some sort of network
server, it is usually difficult to cd into the repo and pull changes. So
we need to push our changes into other repositories.

Let’s start by creating a change to be pushed. Edit the README and
commit it

### *README*

``` file
This is the Hello World example from the git tutorial.
(Changed in the original and pushed to shared)
```

### **Execute:**

``` instructions
git checkout main
git add README
git commit -m "Added shared comment to readme"
```

Now push the change to the shared repo.

### **Execute:**

``` instructions
git push shared main
```

*shared* is the name of the repository receiving the changes we are
pushing. (Remember, we added it as a remote in the previous lab.)

### **Output:**

``` sample
$ git push shared main
To ../hello.git
   5e2d55e..7b4a53a  main -> main
```

**NOTE:** We had to explicitly name the branch main that was receiving
the push. It is possible to set it up automatically, but I *never*
remember the commands to do that. Check out the “Git Remote Branch” gem
for easy management of remote branches.
