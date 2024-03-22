# *lab 12* Getting Old Versions

## Goals

- Learn how to checkout any previous snapshot into the working
  directory.

Going back in history is very easy. The checkout command will copy any
snapshot from the repository to the working directory.

## Get the hashes for previous versions

### **Execute:**

``` instructions
git hist
```

**Note:** You did remember to define `hist` in your `.gitconfig` file,
right? If not, review the lab on aliases.

### **Output:**

``` sample
$ git hist
* e4e3645 2023-06-10 | Added a comment (HEAD -> main) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

Examine the log output and find the hash for the first commit. It should
be the last line of the `git hist` output. Use that hash code (the first
7 characters are enough) in the command below. Then check the contents
of the hello.rb file.

### **Execute:**

``` instructions
git checkout <hash>
cat hello.rb
```

**Note:** The commands given here are Unix commands and work on both Mac
and Linux boxes. Unfortunately, Windows users will have to translate to
their native commands.

**Note:** Many commands depend on the hash values in the repository.
Since your hash values will vary from mine, whenever you see something
like \<hash\> or \<treehash\> in the command, substitute in the proper
hash value for your repository.

You should see …

### **Output:**

``` sample
$ git checkout f7c41d3
Note: switching to 'f7c41d3'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at f7c41d3 First Commit
$ cat hello.rb
puts "Hello, World"
```

The output of the `checkout` command explains the situation pretty well.
Older versions of git will complain about not being on a local branch.
In any case, don’t worry about that for now.

Notice the contents of the hello.rb file are the original contents.

## Return the latest version in the main branch

### **Execute:**

``` instructions
git checkout main
cat hello.rb
```

You should see …

### **Output:**

``` sample
$ git checkout main
Previous HEAD position was f7c41d3 First Commit
Switched to branch 'main'
$ cat hello.rb
# Default is "World"
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

‘main’ is the name of the default branch. By checking out a branch by
name, you go to the latest version of that branch.
