# *lab 3* Create a Project

## Goals

- Learn how to create a git repository from scratch.

## Create a “Hello, World” program

Starting in the empty working directory, create an empty directory named
“hello”, then create a file named `hello.rb` with the contents below.

### **Execute:**

``` instructions
mkdir hello
cd hello
```

### *hello.rb*

``` file
puts "Hello, World"
```

## Create the Repository

You now have a directory with a single file. To create a git repository
from that directory, run the git init command.

### **Execute:**

``` instructions
git init
```

### **Output:**

``` sample
$ git init
Initialized empty Git repository in /Users/jim/Downloads/git_tutorial/work/hello/.git/
```

## Add the program to the repository

Now let’s add the “Hello, World” program to the repository.

### **Execute:**

``` instructions
git add hello.rb
git commit -m "First Commit"
```

You should see …

### **Output:**

``` sample
$ git add hello.rb
$ git commit -m "First Commit"
[main (root-commit) f7c41d3] First Commit
 1 file changed, 1 insertion(+)
 create mode 100644 hello.rb
```
