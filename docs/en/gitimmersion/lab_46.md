# *lab 46* Bare Repositories

## Goals

- Learn how to create bare repositories.

Bare repositories (without working directories) are usually used for
sharing.

## Create a bare repository.

### **Execute:**

``` instructions
cd ..
git clone --bare hello hello.git
ls hello.git
```

**NOTE: Now in the work directory**

### **Output:**

``` sample
$ git clone --bare hello hello.git
Cloning into bare repository 'hello.git'...
done.
$ ls hello.git
HEAD
config
description
hooks
info
objects
packed-refs
refs
```

The convention is that repositories ending in ‘.git’ are bare
repositories. We can see that there is no working directory in the
hello.git repo. Essentially it is nothing but the .git directory of a
non-bare repo.
