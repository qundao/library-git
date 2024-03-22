# *lab 19* Amending Commits

## Goals

- Learn how to amend an existing commit

## Change the program then commit

Add an author comment to the program.

### *hello.rb*

``` file
# Default is World
# Author: Jim Weirich
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

### **Execute:**

``` instructions
git add hello.rb
git commit -m "Add an author comment"
```

## Oops, Should have an Email

After you make the commit, you realize that any good author comment
should have an email included. Update the hello program to include an
email.

### *hello.rb*

``` file
# Default is World
# Author: Jim Weirich (jim@somewhere.com)
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

## Amend the Previous Commit

We really don’t want a separate commit for just the email. Let’s amend
the previous commit to include the email change.

### **Execute:**

``` instructions
git add hello.rb
git commit --amend -m "Add an author/email comment"
```

### **Output:**

``` sample
$ git add hello.rb
$ git commit --amend -m "Add an author/email comment"
[main 186488e] Add an author/email comment
 Date: Sat Jun 10 03:49:14 2023 -0400
 1 file changed, 2 insertions(+), 1 deletion(-)
```

## Review the History

### **Execute:**

``` instructions
git hist
```

### **Output:**

``` sample
$ git hist
* 186488e 2023-06-10 | Add an author/email comment (HEAD -> main) [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

We can see the original “author” commit is now gone, and it is replaced
by the “author/email” commit. You can achieve the same effect by
resetting the branch back one commit and then recommitting the new
changes.
