#!/bin/bash

clear
# Load the colors script
source ../_utils/colors.sh

GIT_REPO=git@github.com:nirgeier/demo-git-assume-unchanged.git

echo -e "${Cyan}* Creating demo repository${Color_Off}"
### Create the demo repository
rm -rf      /tmp/assumeUnChanged
mkdir -p    /tmp/assumeUnChanged
cd          /tmp/assumeUnChanged

### Init the empty repository
echo -e "${Cyan}* Initializing demo repository${Color_Off}"

## Init git repo
git init --quiet
# Add the demo remote repository
git remote add origin $GIT_REPO

# Generate the local README.md file
echo -e "${Cyan}* Initializing README.md file${Color_Off}"
cat << EOF >> README.md
## assume-unchanged demo

This is a simple project to demonstrate how \`git assume-unchanged\` works.
...

EOF

echo -e ""
echo -e "Current README.md file content"
echo -e "------------------------------------------------"
echo -e "${Green}"
cat README.md
echo -e "${Color_Off}"
echo -e "------------------------------------------------"
echo -e ""

# Add all files
echo -e "${Cyan}* Adding content to demo repository${Color_Off}"
git add .

# Commit changes
echo -e "${Cyan}* Commiting content to demo repository${Color_Off}"
git commit -m"Initial Commit" --quiet

echo -e "${Cyan}* Adding second commit with change to demo repository${Color_Off}"
echo "And this is another line added by other developer." >> README.md
echo "" >> README.md

echo -e ""
echo -e "Current README.md file content"
echo -e "------------------------------------------------"
echo -e "${Green}"
cat README.md
echo -e "${Color_Off}"
echo -e "------------------------------------------------"
echo -e ""

# Add all files
echo -e "${Cyan}* Adding content to demo repository${Color_Off}"
git add .

# Commit changes
echo -e "${Cyan}* Commiting content to demo repository${Color_Off}"
git commit -m"Second Commit" --quiet

echo -e "${Cyan}* Pushing content to demo repository${Color_Off}"
echo -e "${Yellow}$GIT_REPO${Color_Off}"

# Push content to server
git push --set-upstream origin main -f --quiet

# Go back commit to simulate changes on server but not locally
echo -e "${Red}* 'Undo' second commit - in order to simulate changes on server${Color_Off}"
git reset HEAD^1 --hard 

# Show diff between local README to the server 
echo -e "${Cyan}* Show diff between local to server${Color_Off}"
git diff origin/main

# Show diff between local README to the server 
echo -e "${Cyan}* Add local change to the file${Color_Off}"
echo "Added local line" >> README.md
echo "" >> README.md

# Mark the file as assume unchanged
echo -e "${Yellow}* Mark the file as assume unchanged${Color_Off}"
git update-index --assume-unchanged README.md

# Mark the file as assume unchanged
echo -e "${Yellow}* Verify assume unchanged${Color_Off}"
echo -e "${Green}$ git ls-files -v | grep '^h'${Color_Off}"
git ls-files -v | grep '^h'

# Pull changes from server
echo -e "${Yellow}* Update content from server${Color_Off}"
echo -e "${Green}$ git status${Color_Off}"
git status 
echo -e "${Green}$ git pull${Color_Off}"
git pull --quiet

echo -e "${Red}>>> Press any key to continue${Color_Off}"

# Wait for user input to continue (max timeout 600 seconds)
read -t 600 -n 1

