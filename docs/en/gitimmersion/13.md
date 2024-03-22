# *lab 13* Tagging versions

## Goals

- Learn how to tag commits with names for future reference

Let’s call the current version of the hello program version 1 (v1).

## Tagging version 1

### **Execute:**

``` instructions
git tag v1
```

Now you can refer to the current version of the program as v1.

## Tagging Previous Versions

Let’s tag the version immediately prior to the current version v1-beta.
First we need to checkout the previous version. Rather than look up the
hash, we will use the `^` notation to indicate “the parent of v1”.

If the `v1`^ notation gives you any trouble, you can also try `v1~1`,
which will reference the same version. This notation means “the first
ancestor of v1”.

### **Execute:**

``` instructions
git checkout v1^
cat hello.rb
```

### **Output:**

``` sample
$ git checkout v1^
Note: switching to 'v1^'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at a6b268e Added a default value
$ cat hello.rb
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

See, this is the version with the default value *before* we added the
comment. Let’s make this v1-beta.

### **Execute:**

``` instructions
git tag v1-beta
```

## Checking Out by Tag Name

Now try going back and forth between the two tagged versions.

### **Execute:**

``` instructions
git checkout v1
git checkout v1-beta
```

### **Output:**

``` sample
$ git checkout v1
Previous HEAD position was a6b268e Added a default value
HEAD is now at e4e3645 Added a comment
$ git checkout v1-beta
Previous HEAD position was e4e3645 Added a comment
HEAD is now at a6b268e Added a default value
```

## Viewing Tags using the `tag` command

You can see what tags are available using the `git tag` command.

### **Execute:**

``` instructions
git tag
```

### **Output:**

``` sample
$ git tag
v1
v1-beta
```

## Viewing Tags in the Logs

You can also check for tags in the log.

### **Execute:**

``` instructions
git hist main --all
```

### **Output:**

``` sample
$ git hist main --all
* e4e3645 2023-06-10 | Added a comment (tag: v1, main) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (HEAD, tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

You can see both tags (`v1` and `v1-beta`) listed in the log output,
along with the branch name (`main`). Also `HEAD` shows you the currently
checked out commit (which is `v1-beta` at the moment).
