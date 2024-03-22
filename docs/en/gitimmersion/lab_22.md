# *lab 22* Git Internals: The .git directory

## Goals

- Learn about the structure of the `.git` directory

## The `.git` Directory

Time to do some exploring. First, from the root of your project
directory…

### **Execute:**

``` instructions
ls -C .git
```

### **Output:**

``` sample
$ ls -C .git
COMMIT_EDITMSG  config      index       objects
HEAD        description info        packed-refs
ORIG_HEAD   hooks       logs        refs
```

This is the magic directory where all the git “stuff” is stored. Let’s
peek in the objects directory.

## The Object Store

### **Execute:**

``` instructions
ls -C .git/objects
```

### **Output:**

``` sample
$ ls -C .git/objects
09  17  24  43  6b  97  af  c4  e7  pack
11  18  27  59  78  9c  b0  cd  f7
14  22  28  69  8b  a6  b5  e4  info
```

You should see a bunch of directories with 2 letter names. The directory
names are the first two letters of the sha1 hash of the object stored in
git.

## Deeper into the Object Store

### **Execute:**

``` instructions
ls -C .git/objects/<dir>
```

### **Output:**

``` sample
$ ls -C .git/objects/09
6b74c56bfc6b40e754fc0725b8c70b2038b91e  9fb6f9d3a104feb32fcac22354c4d0e8a182c1
```

Look in one of the two-letter directories. You should see some files
with 38-character names. These are the files that contain the objects
stored in git. These files are compressed and encoded, so looking at
their contents directly won’t be very helpful, but we will take a closer
look in a bit.

## Config File

### **Execute:**

``` instructions
cat .git/config
```

### **Output:**

``` sample
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
[user]
    name = Jim Weirich
    email = jim (at) edgecase.com
```

This is a project-specific configuration file. Config entries in here
will override the config entries in the `.gitconfig` file in your home
directory, at least for this project.

## Branches and Tags

### **Execute:**

``` instructions
ls .git/refs
ls .git/refs/heads
ls .git/refs/tags
cat .git/refs/tags/v1
```

### **Output:**

``` sample
$ ls .git/refs
heads
tags
$ ls .git/refs/heads
main
$ ls .git/refs/tags
v1
v1-beta
$ cat .git/refs/tags/v1
e4e3645637546103e72f0deb9abdd22dd256601e
```

You should recognize the files in the tags subdirectory. Each file
corresponds to a tag you created with the `git tag` command earlier. Its
content is just the hash of the commit tied to the tag.

The heads directory is similar, but is used for branches rather than
tags. We only have one branch at the moment, so all you will see is main
in this directory.

## The HEAD File

### **Execute:**

``` instructions
cat .git/HEAD
```

### **Output:**

``` sample
$ cat .git/HEAD
ref: refs/heads/main
```

The HEAD file contains a reference to the current branch. It should be a
reference to main at this point.
