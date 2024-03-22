# *lab 30* Resolving Conflicts

## Goals

- Learn how to handle conflicts during a merge

## Merge main to greet

Now go back to the greet branch and try to merge the new main.

### **Execute:**

``` instructions
git checkout greet
git merge main
```

### **Output:**

``` sample
$ git checkout greet
Switched to branch 'greet'
$ git merge main
Auto-merging lib/hello.rb
CONFLICT (content): Merge conflict in lib/hello.rb
Automatic merge failed; fix conflicts and then commit the result.
```

If you open lib/hello.rb, you will see:

### *lib/hello.rb*

``` file
<<<<<<< HEAD
require 'greeter'

# Default is World
name = ARGV.first || "World"

greeter = Greeter.new(name)
puts greeter.greet
=======
# Default is World

puts "What's your name"
my_name = gets.strip

puts "Hello, #{my_name}!"
>>>>>>> main
```

The first section is the version on the head of the current branch
(greet). The second section is the version on the main branch.

## Fix the Conflict

You need to manually resolve the conflict. Modify `lib/hello.rb` to be
the following.

### *lib/hello.rb*

``` file
require 'greeter'

puts "What's your name"
my_name = gets.strip

greeter = Greeter.new(my_name)
puts greeter.greet
```

## Commit the Conflict Resolution

### **Execute:**

``` instructions
git add lib/hello.rb
git commit -m "Merged main fixed conflict."
```

### **Output:**

``` sample
$ git add lib/hello.rb
$ git commit -m "Merged main fixed conflict."
[greet 73db54b] Merged main fixed conflict.
```

## Advanced Merging

git doesn’t provide any graphical merge tools, but it will gladly work
with any third party merge tool you wish to use. See
<http://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#External-Merge-and-Diff-Tools>
for a description of using the Perforce merge tool with git.
