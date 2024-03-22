# *lab 27* Viewing Diverging Branches

## Goals

- Learn how to view diverging branches in a repository.

## View the Current Branches

We now have two diverging branches in the repository. Use the following
log command to view the branches and how they diverge.

### **Execute:**

``` instructions
git hist --all
```

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

Here is our first chance to see the `--graph` option on `git hist` in
action. Adding the `--graph` option to `git log` causes it to draw the
commit tree using simple ASCII characters. We can see both branches
(greet and main), and that the main branch is the current HEAD. The
common ancestor to both branches is the “Added a Rakefile” branch.

The `--all` flag makes sure that we see all the branches. The default is
to show only the current branch.
