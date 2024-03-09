
## Basic Usage

![](../../images/visual-git-guide/basic-usage.svg.png)

The four commands above copy files between the working directory, the
stage (also called the index), and the history (in the form of commits).

- `git add `*`files`* copies *files* (at their current state) to the
  stage.
- `git commit` saves a snapshot of the stage as a commit.
- `git reset -- `*`files`* unstages files; that is, it copies *files*
  from the latest commit to the stage. Use this command to "undo" a
  `git add `*`files`*. You can also `git reset` to unstage everything.
- `git checkout -- `*`files`* copies *files* from the stage to the
  working directory. Use this to throw away local changes.

You can use `git reset -p`, `git checkout -p`, or `git add -p` instead
of (or in addition to) specifying particular files to interactively
choose which hunks copy.

It is also possible to jump over the stage and check out files directly
from the history or commit files without staging first.

![](../../images/visual-git-guide/basic-usage-2.svg.png)

- `git commit -a ` is equivalent to running `git add` on all filenames
  that existed in the latest commit, and then running `git commit`.
- `git commit `*`files`* creates a new commit containing the contents of
  the latest commit, plus a snapshot of *files* taken from the working
  directory. Additionally, *files* are copied to the stage.
- `git checkout HEAD -- `*`files`* copies *files* from the latest commit
  to both the stage and the working directory.
