# *lab 34* Rebasing

## Goals

- Use the rebase command rather than the merge command.

Ok, we are back in time before the first merge and we want to get the
changes in main into our greet branch.

This time we will use the rebase command instead of the merge command to
bring in the changes from the main branch.

### **Execute:**

``` instructions
git checkout greet
git rebase main
git hist
```

### **Output:**

``` sample
$ go greet
Switched to branch 'greet'
$
$ git rebase main
First, rewinding head to replay your work on top of it...
Applying: added Greeter class
Applying: hello uses Greeter
Applying: updated Rakefile
$
$ git hist
* 5f626c6 2023-06-10 | Updated Rakefile (HEAD -> greet) [Jim Weirich]
* 24d82d4 2023-06-10 | Hello uses Greeter [Jim Weirich]
* 619f552 2023-06-10 | Added greeter class [Jim Weirich]
* 976950b 2023-06-10 | Added README (main) [Jim Weirich]
* cdceefa 2023-06-10 | Added a Rakefile. [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

## Merge VS Rebase

The final result of the rebase is very similar to the merge. The greet
branch now contains all of its changes, as well as all the changes from
the main branch. However, the commit tree is quite different. The commit
tree for the greet branch has been rewritten so that the main branch is
a part of the commit history. This leaves the chain of commits linear
and much easier to read.

## When to Rebase, When to Merge?

Don’t use rebase …

1.  If the branch is public and shared with others. Rewriting publicly
    shared branches will tend to screw up other members of the team.
2.  When the *exact* history of the commit branch is important (since
    rebase rewrites the commit history).

Given the above guidelines, I tend to use rebase for short-lived, local
branches and merge for branches in the public repository.
