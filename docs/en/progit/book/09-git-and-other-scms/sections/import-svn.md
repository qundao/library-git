#### Subversion

If you read the previous section about using `git svn`, you can easily
use those instructions to `git svn clone` a repository; then, stop using
the Subversion server, push to a new Git server, and start using that.
If you want the history, you can accomplish that as quickly as you can
pull the data out of the Subversion server (which may take a while).

However, the import isn’t perfect; and because it will take so long, you
may as well do it right. The first problem is the author information. In
Subversion, each person committing has a user on the system who is
recorded in the commit information. The examples in the previous section
show `schacon` in some places, such as the `blame` output and the
`git svn log`. If you want to map this to better Git author data, you
need a mapping from the Subversion users to the Git authors. Create a
file called `users.txt` that has this mapping in a format like this:

```shell
schacon = Scott Chacon <schacon@geemail.com>
selse = Someo Nelse <selse@geemail.com>
```

To get a list of the author names that SVN uses, you can run this:

```shell
$ svn log --xml --quiet | grep author | sort -u | \
  perl -pe 's/.*>(.*?)<.*/$1 = /'
```

That generates the log output in XML format, then keeps only the lines
with author information, discards duplicates, strips out the XML tags.
Obviously this only works on a machine with `grep`, `sort`, and `perl`
installed. Then, redirect that output into your `users.txt` file so you
can add the equivalent Git user data next to each entry.

[TABLE]

You can provide this file to `git svn` to help it map the author data
more accurately. You can also tell `git svn` not to include the metadata
that Subversion normally imports, by passing `--no-metadata` to the
`clone` or `init` command. The metadata includes a `git-svn-id` inside
each commit message that Git will generate during import. This can bloat
your Git log and might make it a bit unclear.

[TABLE]

This makes your `import` command look like this:

```shell
$ git svn clone http://my-project.googlecode.com/svn/ \
      --authors-file=users.txt --no-metadata --prefix "" -s my_project
$ cd my_project
```

Now you should have a nicer Subversion import in your `my_project`
directory. Instead of commits that look like this:

```shell
commit 37efa680e8473b615de980fa935944215428a35a
Author: schacon <schacon@4c93b258-373f-11de-be05-5f7a86268029>
Date:   Sun May 3 00:12:22 2009 +0000

    fixed install - go to trunk

    git-svn-id: https://my-project.googlecode.com/svn/trunk@94 4c93b258-373f-11de-
    be05-5f7a86268029
```

they look like this:

```shell
commit 03a8785f44c8ea5cdb0e8834b7c8e6c469be2ff2
Author: Scott Chacon <schacon@geemail.com>
Date:   Sun May 3 00:12:22 2009 +0000

    fixed install - go to trunk
```

Not only does the Author field look a lot better, but the `git-svn-id`
is no longer there, either.

You should also do a bit of post-import cleanup. For one thing, you
should clean up the weird references that `git svn` set up. First you’ll
move the tags so they’re actual tags rather than strange remote
branches, and then you’ll move the rest of the branches so they’re
local.

To move the tags to be proper Git tags, run:

```shell
$ for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done
```

This takes the references that were remote branches that started with
`refs/remotes/tags/` and makes them real (lightweight) tags.

Next, move the rest of the references under `refs/remotes` to be local
branches:

```shell
$ for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $b refs/remotes/$b && git branch -D -r $b; done
```

It may happen that you’ll see some extra branches which are suffixed by
`@xxx` (where xxx is a number), while in Subversion you only see one
branch. This is actually a Subversion feature called “peg-revisions”,
which is something that Git simply has no syntactical counterpart for.
Hence, `git svn` simply adds the SVN version number to the branch name
just in the same way as you would have written it in SVN to address the
peg-revision of that branch. If you do not care anymore about the
peg-revisions, simply remove them:

```shell
$ for p in $(git for-each-ref --format='%(refname:short)' | grep @); do git branch -D $p; done
```

Now all the old branches are real Git branches and all the old tags are
real Git tags.

There’s one last thing to clean up. Unfortunately, `git svn` creates an
extra branch named `trunk`, which maps to Subversion’s default branch,
but the `trunk` ref points to the same place as `master`. Since `master`
is more idiomatically Git, here’s how to remove the extra branch:

```shell
$ git branch -d trunk
```

The last thing to do is add your new Git server as a remote and push to
it. Here is an example of adding your server as a remote:

```shell
$ git remote add origin git@my-git-server:myrepository.git
```

Because you want all your branches and tags to go up, you can now run
this:

```shell
$ git push origin --all
$ git push origin --tags
```

All your branches and tags should be on your new Git server in a nice,
clean import.

Last updated 2024-03-09 10:34:25 +0800
