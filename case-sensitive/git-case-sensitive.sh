#!/bin/bash

# Clear any exsiting code
rm -rf /tmp/remoteRepository
rm -rf /tmp/localRepository

### Create the dummy repository
git init --bare /tmp/remoteRepository

### Clone the repository
git clone /tmp/remoteRepository /tmp/localRepository

### Switch to the new working directory
cd /tmp/localRepository

###
### Setup the ignorecase flag for the repository
###
git config core.ignorecase true

## Create come content
mkdir -p AAA-folder
echo 'text' > AAA-folder/AAA-file.txt

### Commit the changes
git add AAA-folder/AAA-file.txt
git commit -m "Added AAA-file.txt"

### Push the changes to the remote repository
git push origin main

### Lets now change the folder name
mv AAA-folder aaa-folder

## Let check the staging area for changes
##
## >>> No changes !!!
git status

## List local files and directories
echo "----------------------------------------------------"
echo "Local files:"
echo ""
ls | grep *-folder

## List local files as they are "stored" in git
echo "----------------------------------------------------"
echo "Local git file names:"
echo ""
git ls-tree  main --name-only

## List remotes file and folders
echo "----------------------------------------------------"
echo "Remote files:"
echo ""
git ls-tree -r origin/main --name-only

# Change the case flag to false so that git will trach the changes
git config core.ignorecase false

# Verify that now we see the changes
echo "----------------------------------------------------"
git status

# Clear Demo folder
rm -rf /tmp/remoteRepository
rm -rf /tmp/localRepository
