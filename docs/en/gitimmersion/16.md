# *lab 16* Undoing Committed Changes

## Goals

- Learn how to revert changes that have been committed to a local
  repository.

## Undoing Commits

Sometimes you realized that a change that you have already committed was
not correct and you wish to undo that commit. There are several ways of
handling that issue, and the way we are going to use in this lab is
always safe.

Essentially we will undo the commit by creating a new commit that
reverses the unwanted changes.

## Change the file and commit it.

Change the `hello.rb` file to the following.

### *hello.rb*

``` file
# This is an unwanted but committed change
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

### **Execute:**

``` instructions
git add hello.rb
git commit -m "Oops, we didn't want this commit"
```

## Create a Reverting Commit

To undo a committed change, we need to generate a commit that removes
the changes introduced by our unwanted commit.

### **Execute:**

``` instructions
git revert HEAD
```

This will pop you into the editor. You can edit the default commit
message or leave it as is. Save and close the file. You should see …

### **Output:**

``` sample
$ git revert HEAD --no-edit
[main 8b71812] Revert "Oops, we didn't want this commit"
 Date: Sat Jun 10 03:49:14 2023 -0400
 1 file changed, 1 insertion(+), 1 deletion(-)
```

Since we were undoing the very last commit we made, we were able to use
`HEAD` as the argument to revert. We can revert any arbitrary commit
earlier in history by simply specifying its hash value.

**Note:** The `--no-edit` in the output can be ignored. It was necessary
to generate the output without opening the editor.

## Check the log

Checking the log shows both the unwanted and the reverting commits in
our repository.

### **Execute:**

``` instructions
git hist
```

### **Output:**

``` sample
$ git hist
* 8b71812 2023-06-10 | Revert "Oops, we didn't want this commit" (HEAD -> main) [Jim Weirich]
* 146fb71 2023-06-10 | Oops, we didn't want this commit [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

This technique will work with any commit (although you may have to
resolve conflicts). It is safe to use even on branches that are publicly
shared on remote repositories.

## Up Next

Next, let’s look at a technique that can be used to remove the most
recent commits from the repository history.
