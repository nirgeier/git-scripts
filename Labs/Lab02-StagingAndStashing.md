![](https://raw.githubusercontent.com/nirgeier/labs-assets/main/assets/images/code-wizard-training.png)

# Git Labs

## Exercise 02 - 3 States 

### Overview

* In this lab, we'll take a quick look at 3 states understanding its structure and how to properly use it

### Prerequisite

* Git
  
### Lab

1. Create a new repository and Initialize it with few files and commits ([Lab01](./Lab01-SimpleCommit.md))
2. Create and and new files to the staging area
3. View the staging area 
4. View the staging area **content**. [Use `git ls-files -s`] and explain what you see.
5. Make a change and now stage it interactively (`git add -p`), run `git status` and explain what you see
6. Unstage your change. Use any command you know to "undo" your changes and revert to the committed file

----------------------------------------------------------------

## Solutions

<details>
<summary>Step 1 - Initialize the Repo</summary>

```bash
# Create the folder for our repo
mkdir -p /tmp/git-lab-02

# Switch to that folder
cd /tmp/git-lab-02

# Init the repository
git init

# Add files and commit
for i in {1..5}; 
do 
  echo "Random text... $RANDOM" > file$i.txt; 
  git add . && git commit -m"$RANDOM commit"; 
done

git log
```

</details>

<details>
<summary>Step 2 - Create a file, stage it, and commit </summary>

* Under the hood, the `staging area` is a `file` that contains a `list of files`, as well as the SHA1 of the version that's in the repository.
* Use `git ls-files -s` to view the `hello.txt` file that we checked in previously. 
* The SHA1 hash displayed points to the blob object - which contains the contents of the file.

```sh
# Creating file(s) and adding it to the stage areas
echo 'aaa' > a.txt 
echo 'ccc' > c.txt 

# Add file to the staging area
git add a.txt
```

</details>

<details>

<summary>Step 3 - git status </summary>

```sh
# View the staging area 
git status
```

</details>

<details open>
<summary>Step 4 - View the staging area <b>content</b></summary>

```sh
# View the staging area content
git ls-files -s

### What do you see? Explain
```

</details>

<details open>
<summary>Step 5 - Interactively staging</summary>

```sh
# "update" the content of your files
# by adding first line and last line
# Create a temporary file
temp_file=$(mktemp)
echo "This is new first line" > "$temp_file"
cat a.txt >> "$temp_file"
echo "This is new last line" > "$temp_file"
mv $temp_file a.txt

cat a.txt  
```

</details>


```
$> git ls-files -s
100644 980a0d5f19a64b4b30a87d4206aade58726b60e3 0	hello.txt
```


### Step 2 - Interactive Staging
Make a change to your `hello.txt` file, then use `git add -p` to stage your change interactively. The following is a simple example with only one change to commit. With multiple edits to a code file, for example, git will intelligently break up the changes into "hunks." Git will then display sequentially and ask you whether or not you want to stage each hunk.

```
$> echo "This is a test of the emergency git-casting system." >> hello.txt

$> git add -p
diff --git a/hello.txt b/hello.txt
index 980a0d5..b31a35b 100644
--- a/hello.txt
+++ b/hello.txt
@@ -1 +1,2 @@
 Hello World!
+This is a test of the emergency git-casting system.
Stage this hunk [y,n,q,a,d,/,e,?]?
```
If you type `?` and press `enter` after `Stage this hunk`, git will explain the shortcut keys:

```
Stage this hunk [y,n,q,a,d,/,e,?]?
y - stage this hunk
n - do not stage this hunk
q - quit; do not stage this hunk or any of the remaining ones
a - stage this hunk and all later hunks in the file
d - do not stage this hunk or any of the later hunks in the file
g - select a hunk to go to
/ - search for a hunk matching the given regex
j - leave this hunk undecided, see next undecided hunk
J - leave this hunk undecided, see next hunk
k - leave this hunk undecided, see previous undecided hunk
K - leave this hunk undecided, see previous hunk
s - split the current hunk into smaller hunks
e - manually edit the current hunk
? - print help
```

The change you want to change is listed above, where it says `+This is a test of the emergency git-casting system.` The `+` symbol means that a new line was added, and the following is the contents of the new line. Press `y` and `enter` to stage this hunk. You can now see that `hello.txt` has been staged to be committed.

```
$> git status
On branch exercise2
Your branch is up-to-date with 'origin/exercise2'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   hello.txt
```

Now that we've staged changes to our hello.txt file, let's run `git ls-files -s` again, to see the contents of our staging area:

```
$> git ls-files -s
100644 b31a35bc9c5ae5aff4a0f76f7834cc2428408050 0	hello.txt
```

You'll see that the SHA1 of `hello.txt` has changed. It _was_ `980a0` and it's now `b31a3`.
This mechanism is how git knows that the contents of the staging area have changed.


### Step 3 - Unstage your Change
Say you made a mistake while staging your changes and want to start the staging process over, but without losing the changes to your file. Use `git reset` to remove the files from the staging area, without changing the file in the working area. Use `git status` to see that our modifications to `hello.txt` are still there, but they're no longer staged for commit.

```
$> git reset hello.txt
Unstaged changes after reset:
M	hello.txt

$> git status
On branch exercise2
Your branch is up-to-date with 'origin/exercise2'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   hello.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

The changes to `hello.txt` are still present in the working area, but they were removed from the staging area before being committed to the repository.

### Step 4 - Stash your Changes
Use `git stash` to stash your uncommitted changes. You can unstash these changes later, when you're ready to commit them. It's a good idea to use `git stash save` with a message; this helps you remember what's what if you stash multiple changes.

Then use `git status` to check the status of your working area.

```
$> git stash save "emergency git-casting"
Saved working directory and index state On exercise2: emergency git-casting
HEAD is now at aceb9e8 Initial commit

$> git status
On branch exercise2
Your branch is up-to-date with 'origin/exercise2'.
nothing to commit, working directory clean
```

As you can see, our `HEAD` is still pointed at `exercise2`, and our working directory is clean. The major benefit here is that we are now free to change branches, do other work, etc. without our changes getting in the way.

Now we're ready to apply that change that we stashed. Where is it?

```
$> git stash list
stash@{0}: On exercise2: emergency git-casting
```

Using `git stash list` we can see that we have one stashed change - "emergency git-casting"

We can get more information using `git stash show`:

```
$> git stash show stash@{0}
 hello.txt | 1 +
 1 file changed, 1 insertion(+)
```

There's our change. Let's apply it:

```
$> git stash apply stash@{0}
On branch exercise2
Your branch is up-to-date with 'origin/exercise2'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   hello.txt

no changes added to commit (use "git add" and/or "git commit -a")

$> git diff hello.txt
diff --git a/hello.txt b/hello.txt
index 980a0d5..b31a35b 100644
--- a/hello.txt
+++ b/hello.txt
@@ -1 +1,2 @@
 Hello World!
+This is a test of the emergency git-casting system.
```

Now the change we made earlier to `hello.txt` is back in the working area, but not yet staged for commit.

Tip: `git stash apply` will automatically apply the last stashed change, so no need to use `stash@{0}` if you want to apply something you just stashed.

#### End of Exercise Two
