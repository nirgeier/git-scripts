#!/bin/bash

clear
# Load the colors script
source ../../_utils/colors.sh

### Create the demo repository
rm -rf      /tmp/demo-smudge-merge
mkdir -p    /tmp/demo-smudge-merge
cd          /tmp/demo-smudge-merge

echo -e "${Cyan}* Creating demo repository${Color_Off}"
git init  --quiet
git remote add origin git@github.com:nirgeier/demo-git-smudge-merge.git

echo -e "${Cyan}* Setting config ${Yellow}merge.ours.driver${Color_Off}=${Green}'true'${Color_Off}"
###
### This is the heart of this demo
### Unmark this line to see it in action
###
git config merge.ours.driver true

echo -e "${Cyan}* Commiting few changes${Color_Off}"
git commit --allow-empty -m "Initial commit" --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${Cyan}* Creating second branch [${Yellow}demo-branch${Cyan}]${Color_Off}"
git branch demo-branch --quiet


echo -e "${Cyan}* Mark the file which we wish to set merge stratgies for [${Yellow}version.txt${Cyan}]${Color_Off}"
echo -e "${Cyan}* ${Yellow}version.txt${Color_Off} ${Green}merge=ours${Color_Off} >> .gitattributes"
echo 'version.txt merge=ours' >> .gitattributes

# Createing shared file which will be merged
echo -e "${Cyan}* Createing shared file which will be merged [${Yellow}shared-file.txt${Cyan}]${Color_Off}"
echo -e "Line from ${BRANCH_NAME}"      > shared-file.txt
echo -e "${BRANCH_NAME} - ${RANDOM}"    > version.txt

echo -e "${Cyan}* Adding repostiry content${Color_Off}"
git add . 

echo -e "${Cyan}* Commit changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git commit -m 'Preserve version.txt during merges' --quiet
echo -e "${Cyan}* Pushing changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${Cyan}* Checkout second branch [${Yellow}demo-branch${Cyan}]${Color_Off}"
git checkout demo-branch --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo -e "${Cyan}* Set different version file [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
echo -e "${BRANCH_NAME} - ${RANDOM}" > version.txt
echo -e "${Cyan}* version.txt: ${Yellow}$(cat version.txt)${Color_Off}"

echo -e "${Cyan}* Add content to other file [${Yellow}shared-file.txt${Cyan}]${Color_Off}"
echo -e "Line from ${BRANCH_NAME}"   >> shared-file.txt

echo -e "Content of the shared file: [${Yellow}${BRANCH_NAME}${Color_Off}]"
echo -e "------------------------------------------------"
cat shared-file.txt
echo -e "------------------------------------------------"

echo -e "${Cyan}* Commit changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git add .
git commit -m "Commit updated version to ${BRANCH_NAME}" --quiet
echo -e "${Cyan}* Pushing changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${Cyan}* Checkout the default branch${Color_Off}"
git checkout - --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo -e "${Cyan}* Current branch: [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
echo -e "${Cyan}* Merging form second branch into [${Yellow}${BRANCH_NAME}${Color_Off}] branch"
GIT_EDITOR=true git merge -

echo -e ""
echo -e "Content of the shared file: [${Yellow}${BRANCH_NAME}${Color_Off}]"
echo -e "${Red}We expect to get conflicts since the "
echo -e "file was changed on different branches ${Color_Off}"
echo -e "------------------------------------------------"
cat shared-file.txt
echo -e "------------------------------------------------"

echo -e ""
echo -e "Content of the version.txt: [${Yellow}${BRANCH_NAME}${Color_Off}]"
echo -e "${Green}The file should remain with the current branch content ${Color_Off}"
echo -e "------------------------------------------------"
cat version.txt
echo -e "------------------------------------------------"

echo -e "${Cyan}* Pushing changes to [${Yellow}${BRANCH_NAME}${Cyan}]${Color_Off}"
git push --set-upstream origin ${BRANCH_NAME} -f --quiet