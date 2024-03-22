# *lab 18* Remove the oops tag

## Goals

- Remove the oops tag (housekeeping)

## Removing tag oops

The oops tag has served its purpose. Let’s remove it and allow the
commits it referenced to be garbage collected.

### **Execute:**

``` instructions
git tag -d oops
git hist --all
```

### **Output:**

``` sample
$ git tag -d oops
Deleted tag 'oops' (was 8b71812)
$ git hist --all
* e4e3645 2023-06-10 | Added a comment (HEAD -> main, tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

The oops tag is no longer listed in the repository.
