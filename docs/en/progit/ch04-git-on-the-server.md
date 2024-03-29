## Git on the Server

At this point, you should be able to do most of the day-to-day tasks for
which you’ll be using Git. However, in order to do any collaboration in
Git, you’ll need to have a remote Git repository. Although you can
technically push changes to and pull changes from individuals'
repositories, doing so is discouraged because you can fairly easily
confuse what they’re working on if you’re not careful. Furthermore, you
want your collaborators to be able to access the repository even if your
computer is offline — having a more reliable common repository is often
useful. Therefore, the preferred method for collaborating with someone
is to set up an intermediate repository that you both have access to,
and push to and pull from that.

Running a Git server is fairly straightforward. First, you choose which
protocols you want your server to support. The first section of this
chapter will cover the available protocols and the pros and cons of
each. The next sections will explain some typical setups using those
protocols and how to get your server running with them. Last, we’ll go
over a few hosted options, if you don’t mind hosting your code on
someone else’s server and don’t want to go through the hassle of setting
up and maintaining your own server.

If you have no interest in running your own server, you can skip to the
last section of the chapter to see some options for setting up a hosted
account and then move on to the next chapter, where we discuss the
various ins and outs of working in a distributed source control
environment.

A remote repository is generally a *bare repository* — a Git repository
that has no working directory. Because the repository is only used as a
collaboration point, there is no reason to have a snapshot checked out
on disk; it’s just the Git data. In the simplest terms, a bare
repository is the contents of your project’s `.git` directory and
nothing else.

1.  [protocols](book/04-git-server/sections/protocols.md)

2.  [git-on-a-server](book/04-git-server/sections/git-on-a-server.md)

3.  [generating-ssh-key](book/04-git-server/sections/generating-ssh-key.md)

4.  [setting-up-server](book/04-git-server/sections/setting-up-server.md)

5.  [git-daemon](book/04-git-server/sections/git-daemon.md)

6.  [smart-http](book/04-git-server/sections/smart-http.md)

7.  [gitweb](book/04-git-server/sections/gitweb.md)

8.  [gitlab](book/04-git-server/sections/gitlab.md)

9.  [hosted](book/04-git-server/sections/hosted.md)

### Summary

You have several options to get a remote Git repository up and running
so that you can collaborate with others or share your work.

Running your own server gives you a lot of control and allows you to run
the server within your own firewall, but such a server generally
requires a fair amount of your time to set up and maintain. If you place
your data on a hosted server, it’s easy to set up and maintain; however,
you have to be able to keep your code on someone else’s servers, and
some organizations don’t allow that.

It should be fairly straightforward to determine which solution or
combination of solutions is appropriate for you and your organization.

Last updated 2024-03-09 10:34:37 +0800
