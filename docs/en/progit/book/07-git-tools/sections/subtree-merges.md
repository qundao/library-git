##### Subtree Merging

The idea of the subtree merge is that you have two projects, and one of
the projects maps to a subdirectory of the other one. When you specify a
subtree merge, Git is often smart enough to figure out that one is a
subtree of the other and merge appropriately.

We’ll go through an example of adding a separate project into an
existing project and then merging the code of the second into a
subdirectory of the first.

First, we’ll add the Rack application to our project. We’ll add the Rack
project as a remote reference in our own project and then check it out
into its own branch:

```shell
$ git remote add rack_remote https://github.com/rack/rack
$ git fetch rack_remote --no-tags
warning: no common commits
remote: Counting objects: 3184, done.
remote: Compressing objects: 100% (1465/1465), done.
remote: Total 3184 (delta 1952), reused 2770 (delta 1675)
Receiving objects: 100% (3184/3184), 677.42 KiB | 4 KiB/s, done.
Resolving deltas: 100% (1952/1952), done.
From https://github.com/rack/rack
 * [new branch]      build      -> rack_remote/build
 * [new branch]      master     -> rack_remote/master
 * [new branch]      rack-0.4   -> rack_remote/rack-0.4
 * [new branch]      rack-0.9   -> rack_remote/rack-0.9
$ git checkout -b rack_branch rack_remote/master
Branch rack_branch set up to track remote branch refs/remotes/rack_remote/master.
Switched to a new branch "rack_branch"
```

Now we have the root of the Rack project in our `rack_branch` branch and
our own project in the `master` branch. If you check out one and then
the other, you can see that they have different project roots:

```shell
$ ls
AUTHORS         KNOWN-ISSUES   Rakefile      contrib         lib
COPYING         README         bin           example         test
$ git checkout master
Switched to branch "master"
$ ls
README
```

This is sort of a strange concept. Not all the branches in your
repository actually have to be branches of the same project. It’s not
common, because it’s rarely helpful, but it’s fairly easy to have
branches contain completely different histories.

In this case, we want to pull the Rack project into our `master` project
as a subdirectory. We can do that in Git with `git read-tree`. You’ll
learn more about `read-tree` and its friends in
[ch10-git-internals](ch10-git-internals.md#ch10-git-internals),
but for now know that it reads the root tree of one branch into your
current staging area and working directory. We just switched back to
your `master` branch, and we pull the `rack_branch` branch into the
`rack` subdirectory of our `master` branch of our main project:

```shell
$ git read-tree --prefix=rack/ -u rack_branch
```

When we commit, it looks like we have all the Rack files under that
subdirectory — as though we copied them in from a tarball. What gets
interesting is that we can fairly easily merge changes from one of the
branches to the other. So, if the Rack project updates, we can pull in
upstream changes by switching to that branch and pulling:

```shell
$ git checkout rack_branch
$ git pull
```

Then, we can merge those changes back into our `master` branch. To pull
in the changes and prepopulate the commit message, use the `--squash`
option, as well as the recursive merge strategy’s `-Xsubtree` option.
The recursive strategy is the default here, but we include it for
clarity.

```shell
$ git checkout master
$ git merge --squash -s recursive -Xsubtree=rack rack_branch
Squash commit -- not updating HEAD
Automatic merge went well; stopped before committing as requested
```

All the changes from the Rack project are merged in and ready to be
committed locally. You can also do the opposite — make changes in the
`rack` subdirectory of your `master` branch and then merge them into
your `rack_branch` branch later to submit them to the maintainers or
push them upstream.

This gives us a way to have a workflow somewhat similar to the submodule
workflow without using submodules (which we will cover in
[ch07-git-tools](ch07-git-tools.md#git_submodules)). We can keep
branches with other related projects in our repository and subtree merge
them into our project occasionally. It is nice in some ways, for example
all the code is committed to a single place. However, it has other
drawbacks in that it’s a bit more complex and easier to make mistakes in
reintegrating changes or accidentally pushing a branch into an unrelated
repository.

Another slightly weird thing is that to get a diff between what you have
in your `rack` subdirectory and the code in your `rack_branch`
branch — to see if you need to merge them — you can’t use the normal
`diff` command. Instead, you must run `git diff-tree` with the branch
you want to compare to:

```shell
$ git diff-tree -p rack_branch
```

Or, to compare what is in your `rack` subdirectory with what the
`master` branch on the server was the last time you fetched, you can
run:

```shell
$ git diff-tree -p rack_remote/master
```

Last updated 2024-03-09 10:34:20 +0800
