# *lab 38* Review the Cloned Repository

## Goals

- Learn about branches on remote repositories.

## Look at the cloned repository

Let’s take a look at the cloned repository.

### **Execute:**

``` instructions
cd cloned_hello
ls
```

### **Output:**

``` sample
$ cd cloned_hello
$ ls
README
Rakefile
lib
```

You should see a list of all the files in the top level of the original
repository (`README`, `Rakefile` and `lib`).

## Review the Repository History

### **Execute:**

``` instructions
git hist --all
```

### **Output:**

``` sample
$ git hist --all
* 5f626c6 2023-06-10 | Updated Rakefile (HEAD -> main, origin/main, origin/greet, origin/HEAD) [Jim Weirich]
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

You should now see a list of all the commits in the new repository, and
it should (more or less) match the history of commits in the original
repository. The only difference should be in the names of the branches.

## Remote branches

You should see a **main** branch (along with **HEAD**) in the history
list. But you will also have a number of strangely named branches
(**origin/main**, **origin/greet** and **origin/HEAD**). We’ll talk
about them in a bit.
