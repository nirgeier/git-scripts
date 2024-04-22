#!/bin/bash

clear
# Load the colors script
source ../../_utils/colors.sh

### Create the demo repository
rm -rf      /tmp/demo-smudge-merge
mkdir -p    /tmp/demo-smudge-merge
cd          /tmp/demo-smudge-merge

echo -e "${CYAN}* Creating demo repository${NO_COLOR}"
git init  --quiet
git remote add origin git@github.com:nirgeier/demo-git-smudge-merge.git

echo -e "${CYAN}* Setting config ${YELLOW}merge.ours.driver${NO_COLOR}=${GREEN}'true'${NO_COLOR}"
###
### This is the heart of this demo
### Unmark this line to see it in action
###
git config merge.ours.driver true

echo -e "${CYAN}* Commiting few changes${NO_COLOR}"
git commit --allow-empty -m "Initial commit" --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${CYAN}* Creating second branch [${YELLOW}demo-branch${CYAN}]${NO_COLOR}"
git branch demo-branch --quiet


echo -e "${CYAN}* Mark the file which we wish to set merge stratgies for [${YELLOW}version.txt${CYAN}]${NO_COLOR}"
echo -e "${CYAN}* ${YELLOW}version.txt${NO_COLOR} ${GREEN}merge=ours${NO_COLOR} >> .gitattributes"
echo 'version.txt merge=ours' >> .gitattributes

# Createing shared file which will be merged
echo -e "${CYAN}* Createing shared file which will be merged [${YELLOW}shared-file.txt${CYAN}]${NO_COLOR}"
echo -e "Line from ${BRANCH_NAME}"      > shared-file.txt
echo -e "${BRANCH_NAME} - ${RANDOM}"    > version.txt

echo -e "${CYAN}* Adding repostiry content${NO_COLOR}"
git add . 

echo -e "${CYAN}* Commit changes to [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
git commit -m 'Preserve version.txt during merges' --quiet
echo -e "${CYAN}* Pushing changes to [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${CYAN}* Checkout second branch [${YELLOW}demo-branch${CYAN}]${NO_COLOR}"
git checkout demo-branch --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo -e "${CYAN}* Set different version file [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
echo -e "${BRANCH_NAME} - ${RANDOM}" > version.txt
echo -e "${CYAN}* version.txt: ${YELLOW}$(cat version.txt)${NO_COLOR}"

echo -e "${CYAN}* Add content to other file [${YELLOW}shared-file.txt${CYAN}]${NO_COLOR}"
echo -e "Line from ${BRANCH_NAME}"   >> shared-file.txt

echo -e "Content of the shared file: [${YELLOW}${BRANCH_NAME}${NO_COLOR}]"
echo -e "------------------------------------------------"
cat shared-file.txt
echo -e "------------------------------------------------"

echo -e "${CYAN}* Commit changes to [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
git add .
git commit -m "Commit updated version to ${BRANCH_NAME}" --quiet
echo -e "${CYAN}* Pushing changes to [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
git push --set-upstream origin ${BRANCH_NAME} -f --quiet

echo -e "${CYAN}* Checkout the default branch${NO_COLOR}"
git checkout - --quiet

## Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo -e "${CYAN}* Current branch: [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
echo -e "${CYAN}* Merging form second branch into [${YELLOW}${BRANCH_NAME}${NO_COLOR}] branch"
GIT_EDITOR=true git merge -

echo -e ""
echo -e "Content of the shared file: [${YELLOW}${BRANCH_NAME}${NO_COLOR}]"
echo -e "${RED}We expect to get conflicts since the "
echo -e "file was changed on different branches ${NO_COLOR}"
echo -e "------------------------------------------------"
cat shared-file.txt
echo -e "------------------------------------------------"

echo -e ""
echo -e "Content of the version.txt: [${YELLOW}${BRANCH_NAME}${NO_COLOR}]"
echo -e "${GREEN}The file should remain with the current branch content ${NO_COLOR}"
echo -e "------------------------------------------------"
cat version.txt
echo -e "------------------------------------------------"

echo -e "${CYAN}* Pushing changes to [${YELLOW}${BRANCH_NAME}${CYAN}]${NO_COLOR}"
git push --set-upstream origin ${BRANCH_NAME} -f --quiet