# *lab 50* Hosting your Git Repositories

## Goals

- Learn how to setup git server for sharing repositories.

There are many ways to share git repositories over the network. Here is
a quick and dirty way.

## Start up the git server

### **Execute:**

``` instructions
# (From the work directory)
git daemon --verbose --export-all --base-path=.
```

Now, in a separate terminal window, go to your work directory

### **Execute:**

``` instructions
# (From the work directory)
git clone git://localhost/hello.git network_hello
cd network_hello
ls
```

You should see a copy of hello project.

## Pushing to the Git Daemon

If you want to push to the git daemon repository, add
`--enable=receive-pack` to the git daemon command. Be careful because
there is no authentication on this server, anyone could push to your
repository.
