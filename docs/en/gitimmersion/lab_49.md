# *lab 49* Pulling Shared Changes

## Goals

- Learn how to pull changes from a shared repository.

Quick hop over to the clone repository and let’s pull down the changes
just pushed to the shared repo.

### **Execute:**

``` instructions
cd ../cloned_hello
```

**NOTE: Now in the *cloned_hello* repo.**

Continue with…

### **Execute:**

``` instructions
git remote add shared ../hello.git
git branch --track shared main
git pull shared main
cat README
```
