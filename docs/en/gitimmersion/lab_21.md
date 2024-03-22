# *lab 21* More Structure

## Goals

- Add another file to our repository

## Now add a Rakefile

This lab assumes you have installed **rake**. Please do that before
continuing. Check for your specific Operating System. Otherwise execute:

### **Execute:**

``` instructions
gem install rake
```

Let’s add a Rakefile to our repository. The following one will do
nicely.

### *Rakefile*

``` file
#!/usr/bin/ruby -wKU

task :default => :run

task :run do
  require './lib/hello'
end
```

Add and commit the change.

### **Execute:**

``` instructions
git add Rakefile
git commit -m "Added a Rakefile."
```

You should be able to use Rake to run your hello program now.

### **Execute:**

``` instructions
rake
```

### **Output:**

``` sample
$ rake
Hello, World!
```
