# *lab 23* Git Internals: Working directly with Git Objects

## Goals

- Explore the structure of the object store
- Learn how to use the SHA1 hashes to find content in the repository

Now let’s use some tools to probe git objects directly.

## Finding the Latest Commit

### **Execute:**

``` instructions
git hist --max-count=1
```

This should show the latest commit made in the repository. The SHA1 hash
on your system is probably different from what is on mine, but you
should see something like this.

### **Output:**

``` sample
$ git hist --max-count=1
* cdceefa 2023-06-10 | Added a Rakefile. (HEAD -> main) [Jim Weirich]
```

## Dumping the Latest Commit

Using the SHA1 hash from the commit listed above …

### **Execute:**

``` instructions
git cat-file -t <hash>
git cat-file -p <hash>
```

Here’s my output …

### **Output:**

``` sample
$ git cat-file -t cdceefa
commit
$ git cat-file -p cdceefa
tree 096b74c56bfc6b40e754fc0725b8c70b2038b91e
parent 22273f2a02983d905df7b4154b00447934034338
author Jim Weirich <jim (at) edgecase.com> 1686383357 -0400
committer Jim Weirich <jim (at) edgecase.com> 1686383357 -0400

Added a Rakefile.
```

**NOTE:** If you defined the ‘type’ and ‘dump’ aliases from the aliases
lab, then you can type `git type` and `git dump` rather than the longer
cat-file commands (which I never remember).

This is the dump of the commit object that is at the head of the main
branch. It looks a lot like the commit object from the presentation
earlier.

## Finding the Tree

We can dump the directory tree referenced in the commit. This should be
a description of the (top level) files in our project (for that commit).
Use the SHA1 hash from the “tree” line listed above.

### **Execute:**

``` instructions
git cat-file -p <treehash>
```

Here’s what my tree looks like…

### **Output:**

``` sample
$ git cat-file -p 096b74c
100644 blob 28e0e9d6ea7e25f35ec64a43f569b550e8386f90    Rakefile
040000 tree e46f374f5b36c6f02fb3e9e922b79044f754d795    lib
```

Yep, I see the Rakefile and the lib directory.

## Dumping the lib directory

### **Execute:**

``` instructions
git cat-file -p <libhash>
```

### **Output:**

``` sample
$ git cat-file -p e46f374
100644 blob c45f26b6fdc7db6ba779fc4c385d9d24fc12cf72    hello.rb
```

There’s the `hello.rb` file.

## Dumping the `hello.rb` file

### **Execute:**

``` instructions
git cat-file -p <rbhash>
```

### **Output:**

``` sample
$ git cat-file -p c45f26b
# Default is World
# Author: Jim Weirich (jim@somewhere.com)
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

There you have it. We’ve dumped commit objects, tree objects and blob
objects directly from the git repository. That’s all there is to it,
blobs, trees and commits.

## Explore On You Own

Explore the git repo manually on your own. See if you can find the
original hello.rb file from the very first commit by manually following
the SHA1 hash references starting in the latest commit.
