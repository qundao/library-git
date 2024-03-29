### Rerere

The `git rerere` functionality is a bit of a hidden feature. The name
stands for “reuse recorded resolution” and, as the name implies, it
allows you to ask Git to remember how you’ve resolved a hunk conflict so
that the next time it sees the same conflict, Git can resolve it for you
automatically.

There are a number of scenarios in which this functionality might be
really handy. One of the examples that is mentioned in the documentation
is when you want to make sure a long-lived topic branch will ultimately
merge cleanly, but you don’t want to have a bunch of intermediate merge
commits cluttering up your commit history. With `rerere` enabled, you
can attempt the occasional merge, resolve the conflicts, then back out
of the merge. If you do this continuously, then the final merge should
be easy because `rerere` can just do everything for you automatically.

This same tactic can be used if you want to keep a branch rebased so you
don’t have to deal with the same rebasing conflicts each time you do it.
Or if you want to take a branch that you merged and fixed a bunch of
conflicts and then decide to rebase it instead — you likely won’t have
to do all the same conflicts again.

Another application of `rerere` is where you merge a bunch of evolving
topic branches together into a testable head occasionally, as the Git
project itself often does. If the tests fail, you can rewind the merges
and re-do them without the topic branch that made the tests fail without
having to re-resolve the conflicts again.

To enable `rerere` functionality, you simply have to run this config
setting:

```shell
$ git config --global rerere.enabled true
```

You can also turn it on by creating the `.git/rr-cache` directory in a
specific repository, but the config setting is clearer and enables that
feature globally for you.

Now let’s see a simple example, similar to our previous one. Let’s say
we have a file named `hello.rb` that looks like this:

```shell
#! /usr/bin/env ruby

def hello
  puts 'hello world'
end
```

In one branch we change the word “hello” to “hola”, then in another
branch we change the “world” to “mundo”, just like before.

![Two branches changing the same part of the same file
differently](../../../../../images/progit/rerere1.png)

Figure 1. Two branches changing the same part of the same file
differently

When we merge the two branches together, we’ll get a merge conflict:

```shell
$ git merge i18n-world
Auto-merging hello.rb
CONFLICT (content): Merge conflict in hello.rb
Recorded preimage for 'hello.rb'
Automatic merge failed; fix conflicts and then commit the result.
```

You should notice the new line `Recorded preimage for FILE` in there.
Otherwise it should look exactly like a normal merge conflict. At this
point, `rerere` can tell us a few things. Normally, you might run
`git status` at this point to see what all conflicted:

```shell
$ git status
# On branch master
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add <file>..." to mark resolution)
#
#   both modified:      hello.rb
#
```

However, `git rerere` will also tell you what it has recorded the
pre-merge state for with `git rerere status`:

```shell
$ git rerere status
hello.rb
```

And `git rerere diff` will show the current state of the
resolution — what you started with to resolve and what you’ve resolved
it to.

```shell
$ git rerere diff
--- a/hello.rb
+++ b/hello.rb
@@ -1,11 +1,11 @@
 #! /usr/bin/env ruby

 def hello
-<<<<<<<
-  puts 'hello mundo'
-=======
+<<<<<<< HEAD
   puts 'hola world'
->>>>>>>
+=======
+  puts 'hello mundo'
+>>>>>>> i18n-world
 end
```

Also (and this isn’t really related to `rerere`), you can use
`git ls-files -u` to see the conflicted files and the before, left and
right versions:

```shell
$ git ls-files -u
100644 39804c942a9c1f2c03dc7c5ebcd7f3e3a6b97519 1   hello.rb
100644 a440db6e8d1fd76ad438a49025a9ad9ce746f581 2   hello.rb
100644 54336ba847c3758ab604876419607e9443848474 3   hello.rb
```

Now you can resolve it to just be `puts 'hola mundo'` and you can run
`git rerere diff` again to see what rerere will remember:

```shell
$ git rerere diff
--- a/hello.rb
+++ b/hello.rb
@@ -1,11 +1,7 @@
 #! /usr/bin/env ruby

 def hello
-<<<<<<<
-  puts 'hello mundo'
-=======
-  puts 'hola world'
->>>>>>>
+  puts 'hola mundo'
 end
```

So that basically says, when Git sees a hunk conflict in a `hello.rb`
file that has “hello mundo” on one side and “hola world” on the other,
it will resolve it to “hola mundo”.

Now we can mark it as resolved and commit it:

```shell
$ git add hello.rb
$ git commit
Recorded resolution for 'hello.rb'.
[master 68e16e5] Merge branch 'i18n'
```

You can see that it "Recorded resolution for FILE".

![Recorded resolution for FILE](../../../../../images/progit/rerere2.png)

Figure 2. Recorded resolution for FILE

Now, let’s undo that merge and then rebase it on top of our `master`
branch instead. We can move our branch back by using `git reset` as we
saw in [ch07-git-tools](ch07-git-tools.md#git_reset).

```shell
$ git reset --hard HEAD^
HEAD is now at ad63f15 i18n the hello
```

Our merge is undone. Now let’s rebase the topic branch.

```shell
$ git checkout i18n-world
Switched to branch 'i18n-world'

$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: i18n one word
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging hello.rb
CONFLICT (content): Merge conflict in hello.rb
Resolved 'hello.rb' using previous resolution.
Failed to merge in the changes.
Patch failed at 0001 i18n one word
```

Now, we got the same merge conflict like we expected, but take a look at
the `Resolved FILE using previous resolution` line. If we look at the
file, we’ll see that it’s already been resolved, there are no merge
conflict markers in it.

```shell
#! /usr/bin/env ruby

def hello
  puts 'hola mundo'
end
```

Also, `git diff` will show you how it was automatically re-resolved:

```shell
$ git diff
diff --cc hello.rb
index a440db6,54336ba..0000000
--- a/hello.rb
+++ b/hello.rb
@@@ -1,7 -1,7 +1,7 @@@
  #! /usr/bin/env ruby

  def hello
-   puts 'hola world'
 -  puts 'hello mundo'
++  puts 'hola mundo'
  end
```

![Automatically resolved merge conflict using previous
resolution](../../../../../images/progit/rerere3.png)

Figure 3. Automatically resolved merge conflict using previous
resolution

You can also recreate the conflicted file state with `git checkout`:

```shell
$ git checkout --conflict=merge hello.rb
$ cat hello.rb
#! /usr/bin/env ruby

def hello
<<<<<<< ours
  puts 'hola world'
=======
  puts 'hello mundo'
>>>>>>> theirs
end
```

We saw an example of this in
[ch07-git-tools](ch07-git-tools.md#advanced_merging). For now
though, let’s re-resolve it by just running `git rerere` again:

```shell
$ git rerere
Resolved 'hello.rb' using previous resolution.
$ cat hello.rb
#! /usr/bin/env ruby

def hello
  puts 'hola mundo'
end
```

We have re-resolved the file automatically using the `rerere` cached
resolution. You can now add and continue the rebase to complete it.

```shell
$ git add hello.rb
$ git rebase --continue
Applying: i18n one word
```

So, if you do a lot of re-merges, or want to keep a topic branch up to
date with your `master` branch without a ton of merges, or you rebase
often, you can turn on `rerere` to help your life out a bit.

Last updated 2024-03-09 10:34:16 +0800
