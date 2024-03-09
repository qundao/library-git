## Git Branching

Nearly every VCS has some form of branching support. Branching means you
diverge from the main line of development and continue to do work
without messing with that main line. In many VCS tools, this is a
somewhat expensive process, often requiring you to create a new copy of
your source code directory, which can take a long time for large
projects.

Some people refer to Git’s branching model as its “killer feature,” and
it certainly sets Git apart in the VCS community. Why is it so special?
The way Git branches is incredibly lightweight, making branching
operations nearly instantaneous, and switching back and forth between
branches generally just as fast. Unlike many other VCSs, Git encourages
workflows that branch and merge often, even multiple times in a day.
Understanding and mastering this feature gives you a powerful and unique
tool and can entirely change the way that you develop.

1.  [nutshell](book/03-git-branching/sections/nutshell.md)

2.  [basic-branching-and-merging](book/03-git-branching/sections/basic-branching-and-merging.md)

3.  [branch-management](book/03-git-branching/sections/branch-management.md)

4.  [workflows](book/03-git-branching/sections/workflows.md)

5.  [remote-branches](book/03-git-branching/sections/remote-branches.md)

6.  [rebasing](book/03-git-branching/sections/rebasing.md)

### Summary

We’ve covered basic branching and merging in Git. You should feel
comfortable creating and switching to new branches, switching between
branches and merging local branches together. You should also be able to
share your branches by pushing them to a shared server, working with
others on shared branches and rebasing your branches before they are
shared. Next, we’ll cover what you’ll need to run your own Git
repository-hosting server.

Last updated 2024-03-09 10:34:36 +0800
