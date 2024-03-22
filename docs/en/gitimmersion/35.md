# *lab 35* Merging Back to Main

## Goals

- We’ve kept our greet branch up to date with main (via rebase), now
  let’s merge the greet changes back into the main branch.

## Merge greet into main

### **Execute:**

``` instructions
git checkout main
git merge greet
```

### **Output:**

``` sample
$ git checkout main
Switched to branch 'main'
$
$ git merge greet
Updating 976950b..5f626c6
Fast-forward
 Rakefile       | 2 +-
 lib/greeter.rb | 8 ++++++++
 lib/hello.rb   | 6 ++++--
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 lib/greeter.rb
```

Because the head of main is a direct ancestor of the head of the greet
branch, git is able to do a fast-forward merge. When fast-forwarding,
the branch pointer is simply moved forward to point to the same commit
as the greeter branch.

There will never be conflicts in a fast-forward merge.

## Review the logs

### **Execute:**

``` instructions
git hist
```

### **Output:**

``` sample
$ git hist
* 5f626c6 2023-06-10 | Updated Rakefile (HEAD -> main, greet) [Jim Weirich]
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

The greet and main branches are now identical.
