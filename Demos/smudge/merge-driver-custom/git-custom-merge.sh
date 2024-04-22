#!/bin/bash

clear
# Load the colors script
source ../../_utils/colors.sh

DRIVER_NAME=merge-custom-driver
DRIVER_SCRIPT=merge-script.sh

# Add the merge-script.sh to PATH
PATH=$PATH:`pwd`

### Create the demo repository
rm -rf      /tmp/demo-smudge-merge-custom
mkdir -p    /tmp/demo-smudge-merge-custom
cd          /tmp/demo-smudge-merge-custom

echo -e "${CYAN}* Creating demo repository${NO_COLOR}"
git init  --quiet
git remote add origin git@github.com:nirgeier/demo-git-merge-driver-custom.git

echo -e "${CYAN}* Adding the custom driver to the .gitconfig${NO_COLOR}"
cat << EOF >> .git/config
###
### The driver property contains the command that 
### will be resolve the conflicts.
### 
### +----+---------------------------------------------------------+
### | %O | Ancestor’s    version of the conflicting file           |
### | %A | Current       version of the conflicting file           |
### | %B | Other         (branch) version of the conflicting file  |
### | %P | Path name 	 in which the merged result will be stored |
### | %L |           	 Conflict marker                           |
### +----+---------------------------------------------------------+

### The merge driver is expected to leave the result of the merge 
### in the file named with [%A] by overwriting it,
[merge "${DRIVER_NAME}"]
	name = A custom merge driver for Demo ....
	driver = ${DRIVER_SCRIPT} %O %A %B
EOF

echo -e "Content of ${YELLOW}.git/config${NO_COLOR}"
echo -e "------------------------------------------------"
cat .git/config
echo -e "------------------------------------------------"

echo -e "${CYAN}* Adding the custom driver to the .gitattributes${NO_COLOR}"
echo "*.txt merge=${DRIVER_NAME}" > .gitattributes
echo -e "Content of ${YELLOW}.gitattributes${NO_COLOR}"
echo -e "------------------------------------------------"
cat .gitattributes
echo -e "------------------------------------------------"

echo -e "${CYAN}* Commiting changes${NO_COLOR}"
git add .
git commit -m"Initial Commit" --quiet
## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${CYAN}* Creating the demo branches${NO_COLOR}"
echo -e "${GREEN}\t${BRANCH_NAME}${NO_COLOR}"
echo -e "${GREEN}\tdemo-branch-1${NO_COLOR}"
git branch demo-branch-1
echo -e "${GREEN}\tdemo-branch-2${NO_COLOR}"
git branch demo-branch-2

### -----------------------------------------------------------------
### Build demo-branch-1
echo -e "${CYAN}* Creating content in demo demo-branch-1${NO_COLOR}"
git checkout demo-branch-1

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo $(git rev-parse --abbrev-ref HEAD) > demo-file.txt
echo -e "${CYAN}* Commiting changes to ${BRANCH_NAME}${NO_COLOR}"
git add .
git commit -m"Commit in: ${BRANCH_NAME}" --quiet
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

### -----------------------------------------------------------------
### Build demo-branch-2
echo -e "${CYAN}* Creating content in demo demo-branch-2${NO_COLOR}"
git checkout demo-branch-2

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo $(git rev-parse --abbrev-ref HEAD) > demo-file.txt
echo -e "${CYAN}* Commiting changes to ${BRANCH_NAME}${NO_COLOR}"
git add .
git commit -m"Commit in: ${BRANCH_NAME}" --quiet
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

### -----------------------------------------------------------------
### Merge and cause the conflict
git merge -m"Merged in demo-branch-1" demo-branch-1
git push --set-upstream -u --quiet