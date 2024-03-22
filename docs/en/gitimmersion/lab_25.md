# *lab 25* Navigating Branches

## Goals

- Learn how to navigate between the branches of a repository

You now have two branches in your project:

### **Execute:**

``` instructions
git hist --all
```

### **Output:**

``` sample
$ git hist --all
* c1a7120 2023-06-10 | Updated Rakefile (HEAD -> greet) [Jim Weirich]
* 959a7cb 2023-06-10 | Hello uses Greeter [Jim Weirich]
* cab1837 2023-06-10 | Added greeter class [Jim Weirich]
* cdceefa 2023-06-10 | Added a Rakefile. (main) [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

## Switch to the Main Branch

Just use the `git checkout` command to switch between branches.

### **Execute:**

``` instructions
git checkout main
cat lib/hello.rb
```

### **Output:**

``` sample
$ git checkout main
Switched to branch 'main'
$ cat lib/hello.rb
# Default is World
# Author: Jim Weirich (jim@somewhere.com)
name = ARGV.first || "World"

puts "Hello, #{name}!"
```

You are now on the main branch. You can tell because the hello.rb file
doesn’t use the `Greeter` class.

## Switch Back to the Greet Branch.

### **Execute:**

``` instructions
git checkout greet
cat lib/hello.rb
```

### **Output:**

``` sample
$ git checkout greet
Switched to branch 'greet'
$ cat lib/hello.rb
require 'greeter'

# Default is World
name = ARGV.first || "World"

greeter = Greeter.new(name)
puts greeter.greet
```

The contents of the `lib/hello.rb` confirms we are back on the **greet**
branch.
