### Git in Bash

If you’re a Bash user, you can tap into some of your shell’s features to
make your experience with Git a lot friendlier. Git actually ships with
plugins for several shells, but it’s not turned on by default.

First, you need to get a copy of the completions file from the source
code of the Git release you’re using. Check your version by typing
`git version`, then use `git checkout tags/vX.Y.Z`, where `vX.Y.Z`
corresponds to the version of Git you are using. Copy the
`contrib/completion/git-completion.bash` file somewhere handy, like your
home directory, and add this to your `.bashrc`:

```shell
. ~/git-completion.bash
```

Once that’s done, change your directory to a Git repository, and type:

```shell
$ git chec<tab>
```

…and Bash will auto-complete to `git checkout`. This works with all of
Git’s subcommands, command-line parameters, and remotes and ref names
where appropriate.

It’s also useful to customize your prompt to show information about the
current directory’s Git repository. This can be as simple or complex as
you want, but there are generally a few key pieces of information that
most people want, like the current branch, and the status of the working
directory. To add these to your prompt, just copy the
`contrib/completion/git-prompt.sh` file from Git’s source repository to
your home directory, add something like this to your `.bashrc`:

```shell
. ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)")\$ '
```

The `\w` means print the current working directory, the `\$` prints the
`$` part of the prompt, and `__git_ps1 " (%s)"` calls the function
provided by `git-prompt.sh` with a formatting argument. Now your bash
prompt will look like this when you’re anywhere inside a Git-controlled
project:

![Customized \`bash\` prompt](../../../../../images/progit/git-bash.png)

Figure 1. Customized `bash` prompt

Both of these scripts come with helpful documentation; take a look at
the contents of `git-completion.bash` and `git-prompt.sh` for more
information.

Last updated 2024-03-09 10:34:28 +0800
