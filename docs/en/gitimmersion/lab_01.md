# *lab 1* Setup

## Goals

- To setup git and ruby so that it is ready for work.

## Setup Name and Email

If you have never used git before, you need to do some setup first. Run
the following commands so that git knows your name and email. If you
have git already setup, you can skip down to the line ending section.

### **Execute:**

``` instructions
git config --global user.name "Your Name"
git config --global user.email "your_email@whatever.com"
```

## Setup Line Ending Preferences

Also, for Unix/Mac users:

### **Execute:**

``` instructions
git config --global core.autocrlf input
git config --global core.safecrlf true
```

And for Windows users:

### **Execute:**

``` instructions
git config --global core.autocrlf true
git config --global core.safecrlf true
```

## Setup Ruby

For this tutorial you need a working Ruby interpreter. If you haven´t
one installed yet, it is time to set it up now:

<https://www.ruby-lang.org/en/downloads/>
