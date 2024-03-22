# *lab 41* Change the Original Repository

## Goals

- Make some changes to the original repository so we can try to pull the
  changes

## Make a change in the original **hello** repository

### **Execute:**

``` instructions
cd ../hello
# (You should be in the original hello repository now)
```

**NOTE: Now in the *hello* repo**

Make the following changes to README:

### *README*

``` file
This is the Hello World example from the git tutorial.
(changed in original)
```

Now add and commit this change

### **Execute:**

``` instructions
git add README
git commit -m "Changed README in original repo"
```

## Up Next

The original repository now has later changes that are not in the cloned
version. Next we will pull those changes across to the cloned
repository.
