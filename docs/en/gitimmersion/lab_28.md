# *lab 28* Merging

## Goals

- Learn how to merge two diverging branches to bring the changes back
  into a single branch.

## Merge the branches

Merging brings the changes in two branches together. Let’s go back to
the greet branch and merge main onto greet.

### **Execute:**

``` instructions
git checkout greet
git merge main
git hist --all
```

### **Output:**

``` sample
$ git checkout greet
Switched to branch 'greet'
$ git merge main
Merge made by the 'recursive' strategy.
 README | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 README
$ git hist --all
*   82a2988 2023-06-10 | Merge branch 'main' into greet (HEAD -> greet) [Jim Weirich]
|\
| * 976950b 2023-06-10 | Added README (main) [Jim Weirich]
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

By merging main into your greet branch periodically, you can pick up any
changes to main and keep your changes in greet compatible with changes
in the mainline.

However, it does produce ugly commit graphs. Later we will look at the
option of rebasing rather than merging.

## Up Next

But first, what if the changes in main conflict with the changes in
greet?
