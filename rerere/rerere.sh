#!/bin/bash

clear

# Load the colors script
source ../_utils/colors.sh

# The demo file name which we will use
FILE_NAME=demo-file.txt

git config --global rerere.enabled true
echo -e "${Cyan}* Creating demo repository${Color_Off}"

### Build the repo for bisect
rm -rf  rerere-demo
mkdir   rerere-demo
cd      rerere-demo

echo -e "${Cyan}* Initialize demo repository${Color_Off}"
git init  --quiet
git commit --allow-empty -m "Initial commit" --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo -e "${Cyan}* Creating second branch [${Yellow}demo-branch${Cyan}]${Color_Off}"
git branch demo-branch --quiet

### Working on main branch
# Createing shared file which will be merged
echo -e "${Cyan}* Createing shared file which will be merged [${Yellow}shared-file.txt${Cyan}]${Color_Off}"
echo -e "Line from ${BRANCH_NAME}"      > demo-file.txt

echo -e "Content of the demo file: [${Yellow}${BRANCH_NAME} - demo-file.txt${Color_Off}]"
echo -e "------------------------------------------------"
cat demo-file.txt
echo -e "------------------------------------------------"

echo -e "${Cyan}* Adding repostiry content${Color_Off}"
git add . 

echo -e "${Cyan}* Commit changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git commit -m 'Commit changes' --quiet

echo -e "${Cyan}* Switching to ${Yellow}demo-branch${Cyan} branch${Color_Off}"
### Working on side branch
git checkout demo-branch --quiet

# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Createing shared file which will be merged
echo -e "${Cyan}* Createing shared file which will be merged [${Yellow}shared-file.txt${Cyan}]${Color_Off}"
echo -e "Line from ${BRANCH_NAME}"      > demo-file.txt

echo -e "Content of the demo file: [${Yellow}${BRANCH_NAME} - demo-file.txt${Color_Off}]"
echo -e "------------------------------------------------"
cat demo-file.txt
echo -e "------------------------------------------------"

echo -e "${Cyan}* Adding repostiry content${Color_Off}"
git add . 

echo -e "${Cyan}* Commit changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git commit -m 'Commit changes' --quiet

echo -e "${Cyan}* Setting config ${Yellow}rerere.enabled${Color_Off}=${Green}'true'${Color_Off}"
###
### This is the heart of this demo
### Unmark this line to see it in action
###
git config --global rerere.enabled true

echo -e "${Cyan}* Current branch: [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
echo -e "${Cyan}* Merging form second branch into [${Yellow}${BRANCH_NAME}${Color_Off}] branch"
GIT_EDITOR=true git merge -

### Demo - manual demo
# https://stackoverflow.com/questions/35415925/is-it-possible-to-setup-git-merge-for-automatic-resolving-git-rerere/35417944#35417944

# code . rerere-demo
### Resolve conflicts
# echo 'Resolution' > demo-file.txt
# git add .
# git commit -m"Resolved conflict"
# git reset HEAD~1 --hard
# git merge main
# cat demo-file.txt 
