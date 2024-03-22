# *lab 32* Resetting the Greet Branch

## Goals

- Reset the greet branch to the point before the first merge.

## Reset the greet branch

Let’s go back in time on the greet branch to the point *before* we
merged main onto it. We can **reset** a branch to any commit we want.
Essentially this is modifying the branch pointer to point to anywhere in
the commit tree.

In this case we want to back greet up to the point prior to the merge
with main. We need to find the last commit before the merge.

### **Execute:**

``` instructions
git checkout greet
git hist
```

### **Output:**

``` sample
$ git checkout greet
Already on 'greet'
$ git hist
*   73db54b 2023-06-10 | Merged main fixed conflict. (HEAD -> greet) [Jim Weirich]
|\
| * 3787562 2023-06-10 | Made interactive (main) [Jim Weirich]
* | 82a2988 2023-06-10 | Merge branch 'main' into greet [Jim Weirich]
|\|
| * 976950b 2023-06-10 | Added README [Jim Weirich]
* | c1a7120 2023-06-10 | Updated Rakefile [Jim Weirich]
* | 959a7cb 2023-06-10 | Hello uses Greeter [Jim Weirich]
* | cab1837 2023-06-10 | Added greeter class [Jim Weirich]
|/
* cdceefa 2023-06-10 | Added a Rakefile. [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

That’s a bit hard to read, but looking at the data we see that the
“Updated Rakefile” commit was the last commit on the greet branch before
merging. Let’s reset the greet branch to that commit.

### **Execute:**

``` instructions
git reset --hard <hash>
```

### **Output:**

``` sample
$ git reset --hard c1a7120
HEAD is now at c1a7120 Updated Rakefile
```

## Check the branch.

Look at the log for the greet branch. We no longer have the merge
commits in its history.

### **Execute:**

``` instructions
git hist --all
```

### **Output:**

``` sample
$ git hist --all
* 3787562 2023-06-10 | Made interactive (main) [Jim Weirich]
* 976950b 2023-06-10 | Added README [Jim Weirich]
| * c1a7120 2023-06-10 | Updated Rakefile (HEAD -> greet) [Jim Weirich]
| * 959a7cb 2023-06-10 | Hello uses Greeter [Jim Weirich]
| * cab1837 2023-06-10 | Added greeter class [Jim Weirich]
|/
* cdceefa 2023-06-10 | Added a Rakefile. [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```
