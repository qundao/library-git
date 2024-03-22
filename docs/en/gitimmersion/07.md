# *lab 7* Staging and Committing

A separate staging step in git is in line with the philosophy of getting
out of the way until you need to deal with source control. You can
continue to make changes to your working directory, and then at the
point you want to interact with source control, git allows you to record
your changes in small commits that record exactly what you did.

For example, suppose you edited three files (`a.rb`, `b.rb`, and
`c.rb`). Now you want to commit all the changes, but you want the
changes in `a.rb` and `b.rb` to be a single commit, while the changes to
`c.rb` are not logically related to the first two files and should be a
separate commit.

You could do the following:

``` instructions
git add a.rb
git add b.rb
git commit -m "Changes for a and b"
```

``` instructions
git add c.rb
git commit -m "Unrelated change to c"
```

By separating staging and committing, you have the ability to easily
fine tune what goes into each commit.
