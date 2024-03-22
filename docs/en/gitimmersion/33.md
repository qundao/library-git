# *lab 33* Resetting the Main Branch

## Goals

- Reset the main branch to the point before the conflicting commit.

## Reset the main branch

When we added the interactive mode to the main branch, we made a change
that conflicted with changes in the greet branch. Let’s rewind the main
branch to a point before the conflicting change. This allows us to
demonstrate the rebase command without worrying about conflicts.

### **Execute:**

``` instructions
git checkout main
git hist
```

### **Output:**

``` sample
$ git hist
* 3787562 2023-06-10 | Made interactive (HEAD -> main) [Jim Weirich]
* 976950b 2023-06-10 | Added README [Jim Weirich]
* cdceefa 2023-06-10 | Added a Rakefile. [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

The ‘Added README’ commit is the one directly before the conflicting
interactive mode. We will reset the main branch to ‘Added README’
commit.

### **Execute:**

``` instructions
git reset --hard <hash>
git hist --all
```

Review the log. It should look like the repository has been wound back
in time to the point before we merged anything.

### **Output:**

``` sample
$ git hist --all
* 976950b 2023-06-10 | Added README (HEAD -> main) [Jim Weirich]
| * c1a7120 2023-06-10 | Updated Rakefile (greet) [Jim Weirich]
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
