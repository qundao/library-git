### Command-line Git

One option is to spawn a shell process and use the Git command-line tool
to do the work. This has the benefit of being canonical, and all of
Git’s features are supported. This also happens to be fairly easy, as
most runtime environments have a relatively simple facility for invoking
a process with command-line arguments. However, this approach does have
some downsides.

One is that all the output is in plain text. This means that you’ll have
to parse Git’s occasionally-changing output format to read progress and
result information, which can be inefficient and error-prone.

Another is the lack of error recovery. If a repository is corrupted
somehow, or the user has a malformed configuration value, Git will
simply refuse to perform many operations.

Yet another is process management. Git requires you to maintain a shell
environment on a separate process, which can add unwanted complexity.
Trying to coordinate many of these processes (especially when
potentially accessing the same repository from several processes) can be
quite a challenge.

Last updated 2024-03-09 10:34:31 +0800
