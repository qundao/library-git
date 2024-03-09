
## Technical Notes

The contents of files are not actually stored in the index
(*.git/index*) or in commit objects. Rather, each file is stored in the
object database (*.git/objects*) as a *blob*, identified by its SHA-1
hash. The index file lists the filenames along with the identifier of
the associated blob, as well as some other data. For commits, there is
an additional data type, a *tree*, also identified by its hash. Trees
correspond to directories in the working directory, and contain a list
of trees and blobs corresponding to each filename within that directory.
Each commit stores the identifier of its top-level tree, which in turn
contains all of the blobs and other trees associated with that commit.

If you make a commit using a detached HEAD, the last commit really is
referenced by something: the reflog for HEAD. However, this will expire
after a while, so the commit will eventually be garbage collected,
similar to commits discarded with `git commit --amend` or `git rebase`.
