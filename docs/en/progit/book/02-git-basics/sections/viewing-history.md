### Viewing the Commit History

After you have created several commits, or if you have cloned a
repository with an existing commit history, you’ll probably want to look
back to see what has happened. The most basic and powerful tool to do
this is the `git log` command.

These examples use a very simple project called “simplegit”. To get the
project, run:

```shell
$ git clone https://github.com/schacon/simplegit-progit
```

When you run `git log` in this project, you should get output that looks
something like this:

```shell
$ git log
commit ca82a6dff817ec66f44342007202690a93763949
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Mon Mar 17 21:52:11 2008 -0700

    Change version number

commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Sat Mar 15 16:40:33 2008 -0700

    Remove unnecessary test

commit a11bef06a3f659402fe7563abf99ad00de2209e6
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Sat Mar 15 10:31:28 2008 -0700

    Initial commit
```

By default, with no arguments, `git log` lists the commits made in that
repository in reverse chronological order; that is, the most recent
commits show up first. As you can see, this command lists each commit
with its SHA-1 checksum, the author’s name and email, the date written,
and the commit message.

A huge number and variety of options to the `git log` command are
available to show you exactly what you’re looking for. Here, we’ll show
you some of the most popular.

One of the more helpful options is `-p` or `--patch`, which shows the
difference (the *patch* output) introduced in each commit. You can also
limit the number of log entries displayed, such as using `-2` to show
only the last two entries.

```shell
$ git log -p -2
commit ca82a6dff817ec66f44342007202690a93763949
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Mon Mar 17 21:52:11 2008 -0700

    Change version number

diff --git a/Rakefile b/Rakefile
index a874b73..8f94139 100644
--- a/Rakefile
+++ b/Rakefile
@@ -5,7 +5,7 @@ require 'rake/gempackagetask'
 spec = Gem::Specification.new do |s|
     s.platform  =   Gem::Platform::RUBY
     s.name      =   "simplegit"
-    s.version   =   "0.1.0"
+    s.version   =   "0.1.1"
     s.author    =   "Scott Chacon"
     s.email     =   "schacon@gee-mail.com"
     s.summary   =   "A simple gem for using Git in Ruby code."

commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Sat Mar 15 16:40:33 2008 -0700

    Remove unnecessary test

diff --git a/lib/simplegit.rb b/lib/simplegit.rb
index a0a60ae..47c6340 100644
--- a/lib/simplegit.rb
+++ b/lib/simplegit.rb
@@ -18,8 +18,3 @@ class SimpleGit
     end

 end
-
-if $0 == __FILE__
-  git = SimpleGit.new
-  puts git.show
-end
```

This option displays the same information but with a diff directly
following each entry. This is very helpful for code review or to quickly
browse what happened during a series of commits that a collaborator has
added. You can also use a series of summarizing options with `git log`.
For example, if you want to see some abbreviated stats for each commit,
you can use the `--stat` option:

```shell
$ git log --stat
commit ca82a6dff817ec66f44342007202690a93763949
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Mon Mar 17 21:52:11 2008 -0700

    Change version number

 Rakefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Sat Mar 15 16:40:33 2008 -0700

    Remove unnecessary test

 lib/simplegit.rb | 5 -----
 1 file changed, 5 deletions(-)

commit a11bef06a3f659402fe7563abf99ad00de2209e6
Author: Scott Chacon <schacon@gee-mail.com>
Date:   Sat Mar 15 10:31:28 2008 -0700

    Initial commit

 README           |  6 ++++++
 Rakefile         | 23 +++++++++++++++++++++++
 lib/simplegit.rb | 25 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
```

As you can see, the `--stat` option prints below each commit entry a
list of modified files, how many files were changed, and how many lines
in those files were added and removed. It also puts a summary of the
information at the end.

Another really useful option is `--pretty`. This option changes the log
output to formats other than the default. A few prebuilt option values
are available for you to use. The `oneline` value for this option prints
each commit on a single line, which is useful if you’re looking at a lot
of commits. In addition, the `short`, `full`, and `fuller` values show
the output in roughly the same format but with less or more information,
respectively:

```shell
$ git log --pretty=oneline
ca82a6dff817ec66f44342007202690a93763949 Change version number
085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7 Remove unnecessary test
a11bef06a3f659402fe7563abf99ad00de2209e6 Initial commit
```

The most interesting option value is `format`, which allows you to
specify your own log output format. This is especially useful when
you’re generating output for machine parsing — because you specify the
format explicitly, you know it won’t change with updates to Git:

```shell
$ git log --pretty=format:"%h - %an, %ar : %s"
ca82a6d - Scott Chacon, 6 years ago : Change version number
085bb3b - Scott Chacon, 6 years ago : Remove unnecessary test
a11bef0 - Scott Chacon, 6 years ago : Initial commit
```

[Useful specifiers for `git log --pretty=format`](#pretty_format) lists
some of the more useful specifiers that `format` takes.

| Specifier | Description of Output                             |
|-----------|---------------------------------------------------|
| `%H`      | Commit hash                                       |
| `%h`      | Abbreviated commit hash                           |
| `%T`      | Tree hash                                         |
| `%t`      | Abbreviated tree hash                             |
| `%P`      | Parent hashes                                     |
| `%p`      | Abbreviated parent hashes                         |
| `%an`     | Author name                                       |
| `%ae`     | Author email                                      |
| `%ad`     | Author date (format respects the `--date=option`) |
| `%ar`     | Author date, relative                             |
| `%cn`     | Committer name                                    |
| `%ce`     | Committer email                                   |
| `%cd`     | Committer date                                    |
| `%cr`     | Committer date, relative                          |
| `%s`      | Subject                                           |

Table 1. Useful specifiers for `git log --pretty=format`
{#pretty_format}

You may be wondering what the difference is between *author* and
*committer*. The author is the person who originally wrote the work,
whereas the committer is the person who last applied the work. So, if
you send in a patch to a project and one of the core members applies the
patch, both of you get credit — you as the author, and the core member
as the committer. We’ll cover this distinction a bit more in
[ch05-distributed-git](ch05-distributed-git.md#ch05-distributed-git).

The `oneline` and `format` option values are particularly useful with
another `log` option called `--graph`. This option adds a nice little
ASCII graph showing your branch and merge history:

```shell
$ git log --pretty=format:"%h %s" --graph
* 2d3acf9 Ignore errors from SIGCHLD on trap
*  5e3ee11 Merge branch 'master' of https://github.com/dustin/grit.git
|\
| * 420eac9 Add method for getting the current branch
* | 30e367c Timeout code and tests
* | 5a09431 Add timeout protection to grit
* | e1193f8 Support for heads with slashes in them
|/
* d6016bc Require time for xmlschema
*  11d191e Merge branch 'defunkt' into local
```

This type of output will become more interesting as we go through
branching and merging in the next chapter.

Those are only some simple output-formatting options to
`git log` — there are many more. [Common options to
`git log`](#log_options) lists the options we’ve covered so far, as well
as some other common formatting options that may be useful, along with
how they change the output of the `log` command.

| Option            | Description                                                                                                                                        |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `-p`              | Show the patch introduced with each commit.                                                                                                        |
| `--stat`          | Show statistics for files modified in each commit.                                                                                                 |
| `--shortstat`     | Display only the changed/insertions/deletions line from the `--stat` command.                                                                      |
| `--name-only`     | Show the list of files modified after the commit information.                                                                                      |
| `--name-status`   | Show the list of files affected with added/modified/deleted information as well.                                                                   |
| `--abbrev-commit` | Show only the first few characters of the SHA-1 checksum instead of all 40.                                                                        |
| `--relative-date` | Display the date in a relative format (for example, “2 weeks ago”) instead of using the full date format.                                          |
| `--graph`         | Display an ASCII graph of the branch and merge history beside the log output.                                                                      |
| `--pretty`        | Show commits in an alternate format. Option values include `oneline`, `short`, `full`, `fuller`, and `format` (where you specify your own format). |
| `--oneline`       | Shorthand for `--pretty=oneline --abbrev-commit` used together.                                                                                    |

Table 2. Common options to `git log` {#log_options}

#### Limiting Log Output

In addition to output-formatting options, `git log` takes a number of
useful limiting options; that is, options that let you show only a
subset of commits. You’ve seen one such option already — the `-2`
option, which displays only the last two commits. In fact, you can do
`-<n>`, where `n` is any integer to show the last `n` commits. In
reality, you’re unlikely to use that often, because Git by default pipes
all output through a pager so you see only one page of log output at a
time.

However, the time-limiting options such as `--since` and `--until` are
very useful. For example, this command gets the list of commits made in
the last two weeks:

```shell
$ git log --since=2.weeks
```

This command works with lots of formats — you can specify a specific
date like `"2008-01-15"`, or a relative date such as
`"2 years 1 day 3 minutes ago"`.

You can also filter the list to commits that match some search criteria.
The `--author` option allows you to filter on a specific author, and the
`--grep` option lets you search for keywords in the commit messages.

[TABLE]

Another really helpful filter is the `-S` option (colloquially referred
to as Git’s “pickaxe” option), which takes a string and shows only those
commits that changed the number of occurrences of that string. For
instance, if you wanted to find the last commit that added or removed a
reference to a specific function, you could call:

```shell
$ git log -S function_name
```

The last really useful option to pass to `git log` as a filter is a
path. If you specify a directory or file name, you can limit the log
output to commits that introduced a change to those files. This is
always the last option and is generally preceded by double dashes (`--`)
to separate the paths from the options:

```shell
$ git log -- path/to/file
```

In [Options to limit the output of `git log`](#limit_options) we’ll list
these and a few other common options for your reference.

| Option                | Description                                                                  |
|-----------------------|------------------------------------------------------------------------------|
| `-<n>`                | Show only the last n commits.                                                |
| `--since`, `--after`  | Limit the commits to those made after the specified date.                    |
| `--until`, `--before` | Limit the commits to those made before the specified date.                   |
| `--author`            | Only show commits in which the author entry matches the specified string.    |
| `--committer`         | Only show commits in which the committer entry matches the specified string. |
| `--grep`              | Only show commits with a commit message containing the string.               |
| `-S`                  | Only show commits adding or removing code matching the string.               |

Table 3. Options to limit the output of `git log` {#limit_options}

For example, if you want to see which commits modifying test files in
the Git source code history were committed by Junio Hamano in the month
of October 2008 and are not merge commits, you can run something like
this:

```shell
$ git log --pretty="%h - %s" --author='Junio C Hamano' --since="2008-10-01" \
   --before="2008-11-01" --no-merges -- t/
5610e3b - Fix testcase failure when extended attributes are in use
acd3b9e - Enhance hold_lock_file_for_{update,append}() API
f563754 - demonstrate breakage of detached checkout with symbolic link HEAD
d1a43f2 - reset --hard/read-tree --reset -u: remove unmerged new paths
51a94af - Fix "checkout --track -b newbranch" on detached HEAD
b0ad11e - pull: allow "git pull origin $something:$current_branch" into an unborn branch
```

Of the nearly 40,000 commits in the Git source code history, this
command shows the 6 that match those criteria.

[TABLE]

Last updated 2024-03-09 10:34:03 +0800
