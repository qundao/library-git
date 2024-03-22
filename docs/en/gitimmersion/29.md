# *lab 29* Creating a Conflict

## Goals

- Create a conflicting change in the main branch.

## Switch back to main and create a conflict

Switch back to the main branch and make this change:

### **Execute:**

``` instructions
git checkout main
```

### *lib/hello.rb*

``` file
puts "What's your name"
my_name = gets.strip

puts "Hello, #{my_name}!"
```

### **Execute:**

``` instructions
git add lib/hello.rb
git commit -m "Made interactive"
```

## View the Branches

### **Execute:**

``` instructions
git hist --all
```

### **Output:**

``` sample
$ git hist --all
*   82a2988 2023-06-10 | Merge branch 'main' into greet (greet) [Jim Weirich]
|\
* | c1a7120 2023-06-10 | Updated Rakefile [Jim Weirich]
* | 959a7cb 2023-06-10 | Hello uses Greeter [Jim Weirich]
* | cab1837 2023-06-10 | Added greeter class [Jim Weirich]
| | * 3787562 2023-06-10 | Made interactive (HEAD -> main) [Jim Weirich]
| |/
| * 976950b 2023-06-10 | Added README [Jim Weirich]
|/
* cdceefa 2023-06-10 | Added a Rakefile. [Jim Weirich]
* 22273f2 2023-06-10 | Moved hello.rb to lib [Jim Weirich]
* 186488e 2023-06-10 | Add an author/email comment [Jim Weirich]
* e4e3645 2023-06-10 | Added a comment (tag: v1) [Jim Weirich]
* a6b268e 2023-06-10 | Added a default value (tag: v1-beta) [Jim Weirich]
* 174dfab 2023-06-10 | Using ARGV [Jim Weirich]
* f7c41d3 2023-06-10 | First Commit [Jim Weirich]
```

main at commit “Added README” has been merged to the greet branch, but
there is now an additional commit on main that has not been merged back
to greet.

## Up Next

The latest change in main conflicts with some existing changes in greet.
Next we will resolve those changes.
