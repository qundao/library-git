# *lab 24* Creating a Branch

## Goals

- Learn how to create a local branch in a repository

It’s time to do a major rewrite of the hello world functionality. Since
this might take awhile, you’ll want to put these changes into a separate
branch to isolate them from changes in main.

## Create a Branch

Let’s call our new branch ‘greet’.

### **Execute:**

``` instructions
git checkout -b greet
git status
```

**NOTE:** `git checkout -b <branchname>` is a shortcut for
`git branch <branchname>` followed by a `git checkout <branchname>`.

Notice that the git status command reports that you are on the ‘greet’
branch.

## Changes for Greet: Add a Greeter class.

### *lib/greeter.rb*

``` file
class Greeter
  def initialize(who)
    @who = who
  end
  def greet
    "Hello, #{@who}"
  end
end
```

### **Execute:**

``` instructions
git add lib/greeter.rb
git commit -m "Added greeter class"
```

## Changes for Greet: Modify the main program

Update the hello.rb file to use greeter

### *lib/hello.rb*

``` file
require 'greeter'

# Default is World
name = ARGV.first || "World"

greeter = Greeter.new(name)
puts greeter.greet
```

### **Execute:**

``` instructions
git add lib/hello.rb
git commit -m "Hello uses Greeter"
```

## Changes for Greet: Update the Rakefile

Update the Rakefile to use an external ruby process

### *Rakefile*

``` file
#!/usr/bin/ruby -wKU

task :default => :run

task :run do
  ruby '-Ilib', 'lib/hello.rb'
end
```

### **Execute:**

``` instructions
git add Rakefile
git commit -m "Updated Rakefile"
```

## Up Next

We now have a new branch called **greet** with 3 new commits on it. Next
we will learn how to navigate and switch between branches.
