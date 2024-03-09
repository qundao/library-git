
## Walkthrough: Watching the effect of commands

The following walks you through changes to a repository so you can see
the effect of the command in real time, similar to how [Visualizing Git
Concepts with D3](http://onlywei.github.io/explain-git-with-d3/#)
simulates them visually. Hopefully you find this useful.

Start by creating some repository:

    $ git init foo
    $ cd foo
    $ echo 1 > myfile
    $ git add myfile
    $ git commit -m "version 1"

Now, define the following functions to help us show information:

    show_status() {
      echo "HEAD:     $(git cat-file -p HEAD:myfile)"
      echo "Stage:    $(git cat-file -p :myfile)"
      echo "Worktree: $(cat myfile)"
    }

    initial_setup() {
      echo 3 > myfile
      git add myfile
      echo 4 > myfile
      show_status
    }

Initially, everything is at version 1.

    $ show_status
    HEAD:     1
    Stage:    1
    Worktree: 1

We can watch the state change as we add and commit.

    $ echo 2 > myfile
    $ show_status
    HEAD:     1
    Stage:    1
    Worktree: 2
    $ git add myfile
    $ show_status
    HEAD:     1
    Stage:    2
    Worktree: 2
    $ git commit -m "version 2"
    [main 4156116] version 2
     1 file changed, 1 insertion(+), 1 deletion(-)
    $ show_status
    HEAD:     2
    Stage:    2
    Worktree: 2

Now, let's create an initial state where the three are all different.

    $ initial_setup
    HEAD:     2
    Stage:    3
    Worktree: 4

Let's watch what each command does. You will see that they match the
diagrams above.

`git reset -- myfile` copies from HEAD to stage:

    $ initial_setup
    HEAD:     2
    Stage:    3
    Worktree: 4
    $ git reset -- myfile
    Unstaged changes after reset:
    M   myfile
    $ show_status
    HEAD:     2
    Stage:    2
    Worktree: 4

`git checkout -- myfile` copies from stage to worktree:

    $ initial_setup
    HEAD:     2
    Stage:    3
    Worktree: 4
    $ git checkout -- myfile
    $ show_status
    HEAD:     2
    Stage:    3
    Worktree: 3

`git checkout HEAD -- myfile` copies from HEAD to both stage and
worktree:

    $ initial_setup
    HEAD:     2
    Stage:    3
    Worktree: 4
    $ git checkout HEAD -- myfile
    $ show_status
    HEAD:     2
    Stage:    2
    Worktree: 2

`git commit myfile` copies from worktree to both stage and HEAD:

    $ initial_setup
    HEAD:     2
    Stage:    3
    Worktree: 4
    $ git commit myfile -m "version 4"
    [main 679ff51] version 4
     1 file changed, 1 insertion(+), 1 deletion(-)
    $ show_status
    HEAD:     4
    Stage:    4
    Worktree: 4
