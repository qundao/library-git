# *lab 37* Cloning Repositories

## Goals

- Learn how to make copies of repositories.

## Go to the work directory

Go to the working directory and make a clone of your hello repository.

### **Execute:**

``` instructions
cd ..
pwd
ls
```

**NOTE: Now in the work directory.**

### **Output:**

``` sample
$ cd ..
$ pwd
/Users/jim/Downloads/git_tutorial/work
$ ls
hello
```

At this point you should be in your “work” directory. There should be a
single repository here named “hello”.

## Create a clone of the hello repository

Let’s make a clone of the repository.

### **Execute:**

``` instructions
git clone hello cloned_hello
ls
```

### **Output:**

``` sample
$ git clone hello cloned_hello
Cloning into 'cloned_hello'...
done.
$ ls
cloned_hello
hello
```

There should now be two repositories in your work directory: the
original “hello” repository and the newly cloned “cloned_hello”
repository.
