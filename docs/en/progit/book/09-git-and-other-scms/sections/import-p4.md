#### Perforce

The next system you’ll look at importing from is Perforce. As we
discussed above, there are two ways to let Git and Perforce talk to each
other: git-p4 and Perforce Git Fusion.

##### Perforce Git Fusion

Git Fusion makes this process fairly painless. Just configure your
project settings, user mappings, and branches using a configuration file
(as discussed in [\[\_p4_git_fusion\]](#_p4_git_fusion)), and clone the
repository. Git Fusion leaves you with what looks like a native Git
repository, which is then ready to push to a native Git host if you
desire. You could even use Perforce as your Git host if you like.

##### Git-p4

Git-p4 can also act as an import tool. As an example, we’ll import the
Jam project from the Perforce Public Depot. To set up your client, you
must export the P4PORT environment variable to point to the Perforce
depot:

```shell
$ export P4PORT=public.perforce.com:1666
```

[TABLE]

Run the `git p4 clone` command to import the Jam project from the
Perforce server, supplying the depot and project path and the path into
which you want to import the project:

```shell
$ git-p4 clone //guest/perforce_software/jam@all p4import
Importing from //guest/perforce_software/jam@all into p4import
Initialized empty Git repository in /private/tmp/p4import/.git/
Import destination: refs/remotes/p4/master
Importing revision 9957 (100%)
```

This particular project has only one branch, but if you have branches
that are configured with branch views (or just a set of directories),
you can use the `--detect-branches` flag to `git p4 clone` to import all
the project’s branches as well. See
[\[\_git_p4_branches\]](#_git_p4_branches) for a bit more detail on
this.

At this point you’re almost done. If you go to the `p4import` directory
and run `git log`, you can see your imported work:

```shell
$ git log -2
commit e5da1c909e5db3036475419f6379f2c73710c4e6
Author: giles <giles@giles@perforce.com>
Date:   Wed Feb 8 03:13:27 2012 -0800

    Correction to line 355; change </UL> to </OL>.

    [git-p4: depot-paths = "//public/jam/src/": change = 8068]

commit aa21359a0a135dda85c50a7f7cf249e4f7b8fd98
Author: kwirth <kwirth@perforce.com>
Date:   Tue Jul 7 01:35:51 2009 -0800

    Fix spelling error on Jam doc page (cummulative -> cumulative).

    [git-p4: depot-paths = "//public/jam/src/": change = 7304]
```

You can see that `git-p4` has left an identifier in each commit message.
It’s fine to keep that identifier there, in case you need to reference
the Perforce change number later. However, if you’d like to remove the
identifier, now is the time to do so – before you start doing work on
the new repository. You can use `git filter-branch` to remove the
identifier strings en masse:

```shell
$ git filter-branch --msg-filter 'sed -e "/^\[git-p4:/d"'
Rewrite e5da1c909e5db3036475419f6379f2c73710c4e6 (125/125)
Ref 'refs/heads/master' was rewritten
```

If you run `git log`, you can see that all the SHA-1 checksums for the
commits have changed, but the `git-p4` strings are no longer in the
commit messages:

```shell
$ git log -2
commit b17341801ed838d97f7800a54a6f9b95750839b7
Author: giles <giles@giles@perforce.com>
Date:   Wed Feb 8 03:13:27 2012 -0800

    Correction to line 355; change </UL> to </OL>.

commit 3e68c2e26cd89cb983eb52c024ecdfba1d6b3fff
Author: kwirth <kwirth@perforce.com>
Date:   Tue Jul 7 01:35:51 2009 -0800

    Fix spelling error on Jam doc page (cummulative -> cumulative).
```

Your import is ready to push up to your new Git server.

Last updated 2024-03-09 10:34:24 +0800
