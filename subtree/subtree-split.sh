#!/bin/bash

# Load the colors script
source ../_utils/colors.sh

clear
rm -rf      /tmp/subtree-split-demo
mkdir -p    /tmp/subtree-split-demo
cd          /tmp/subtree-split-demo

# Init git repo
git init

echo -e "${Green}Creating dummy git content ${Color_Off}"

# Create dummy content
mkdir -p {client,server}

# Create dummy commits in client folder
for i in {10..19}
do
    # Commit to the client folder
    echo "Commit #: $i" >> ./client/file.txt
    git add .
    git commit -m"Client - Commit #${i}" 1> /dev/null

    # Commit to the server folder
    echo "Commit #: $((i+10))" >> ./server/file.txt
    git add .
    git commit -m"Server - Commit #$((i+10))" 1> /dev/null
done

echo -e "${Green}Creating branch for split ${Color_Off}"
git checkout -b branch1

echo -e "${Green}Split the content ${Color_Off}"
echo -e "${Yellow}-----------------------------------"
git subtree split -P client -b client_branch 
echo -e "${Yellow}-----------------------------------"
git subtree split -P server -b server_branch 
echo -e "${Yellow}-----------------------------------"

echo -e "${Yellow}List branches"
git branch -a

echo -e "${Yellow}-----------------------------------"
echo -e "${Yellow}View Client branch content"
git log --oneline --graph --decorate client_branch

echo -e "${Yellow}-----------------------------------"
echo -e "${Yellow}View Server branch content"
git log --oneline --graph --decorate server_branch

# echo -e "-----------------------------------"

# git log --oneline --graph --decorate --all 