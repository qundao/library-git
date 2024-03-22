# *lab 42* Fetching Changes

## Goals

- Learn how to pull changes from a remote repository.

### **Execute:**

``` instructions
cd ../cloned_hello
git fetch
git hist --all
```

**NOTE: Now in the *cloned_hello* repo**

### **Output:**

``` sample
$ git fetch
From /Users/jim/Downloads/git_tutorial/work/hello
   5f626c6..5e2d55e  main       -> origin/main
$ git hist --all
* 5e2d55e 2023-06-10 | Changed README in original repo (origin/main, origin/HEAD) [Jim Weirich]
* 5f626c6 2023-06-10 | Updated Rakefile (HEAD -> main, origin/greet) [Jim Weirich]
* 24d82d4 2023-06-10 | Hello uses Greeter [Jim Weirich]
* 619f552 2023-06-10 | Added greeter class [Jim Weirich]
* 976950b 2023-06-10 | Added README [Jim Weirich]
* cdceefa 2023-06-10 | Added a Rakefile. [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

At this point the repository has all the commits from the original
repository, but they are not integrated into the cloned repository’s
local branches.

Find the “Changed README in original repo” commit in the history above.
Notice that the commit includes “origin/main” and “origin/HEAD”.

Now look at the “Updated Rakefile” commit. You will see that the local
main branch points to this commit, not to the new commit that we just
fetched.

The upshot of this is that the “git fetch” command will fetch new
commits from the remote repository, but it will not merge these commits
into the local branches.

## Check the README

We can demonstrate that the cloned README is unchanged.

### **Execute:**

``` instructions
cat README
```

### **Output:**

``` sample
$ cat README
This is the Hello World example from the git tutorial.
```

See, no changes.
