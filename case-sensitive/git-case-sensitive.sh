#!/bin/bash

clear

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

# Load the colors script
source ../_utils/colors.sh
source ../_utils/utils.sh

# Genrate dummy repostitory
generate_repository

###
### Setup the ignorecase flag for the repository
###
echo -e ""
echo -e "${YELLOW}-------------------------------       ${NO_COLOR}"
echo -e "${YELLOW}Set up ignorecase flag to  ${RED}true ${NO_COLOR}"
echo -e "${GREEN}git config core.ignorecase ${RED}true  ${NO_COLOR}"
echo -e "${YELLOW}-------------------------------       ${NO_COLOR}"
git config core.ignorecase true

## Create some content
echo -e ""
echo -e "${YELLOW}* Creating file(s) with uppercase ${RED}FILE.txt ${NO_COLOR}"
echo 'text' > FILE.txt

echo -e ""
echo -e "${YELLOW}* Adding and commiting ${NO_COLOR}"
git add . && git commit -m "Added FILE.txt"

echo -e ""
echo -e "${YELLOW}* Review files in commit ${NO_COLOR}"
echo -e "${RED}  $(git diff-tree --no-commit-id --name-only HEAD -r) ${NO_COLOR}"

echo -e ""
echo -e "${YELLOW}* Rename file to lowercase ${RED}FILE.txt > file.txt${NO_COLOR}"
mv FILE.txt file.txt

echo -e ""
echo -e "${YELLOW}* List of files in the folder       ${NO_COLOR}"
echo -e "${GREEN}"
find . -maxdepth 1 -type f
echo -e "${NO_COLOR}"

echo -e ""
echo -e "${YELLOW}* View status for changes ${NO_COLOR}"
echo -e "${YELLOW}-------------------------------       ${NO_COLOR}"
git status

echo -e ""
echo -e "${YELLOW}----------------------------------       ${NO_COLOR}"
echo -e "${YELLOW}Set up ignorecase flag to  ${RED}false ${NO_COLOR}"
echo -e "${GREEN}git config core.ignorecase ${RED}false  ${NO_COLOR}"
echo -e "${YELLOW}----------------------------------       ${NO_COLOR}"
git config core.ignorecase false

echo -e "${YELLOW}* View status for changes ${NO_COLOR}"
echo -e "${YELLOW}-------------------------------       ${NO_COLOR}"
git status
echo -e "${YELLOW}-------------------------------       ${NO_COLOR}"

# ls -la

# echo -e "${YELLOW}------------------------------- ${NO_COLOR}"
# echo -e "${YELLOW}Set up ignorecase flag to ${GREEN}false ${NO_COLOR}"
# echo -e "${GREEN}git config core.ignorecase ${YELLOW}true ${NO_COLOR}"
# echo -e "${YELLOW}------------------------------- ${NO_COLOR}"
# echo ""
# git config core.ignorecase false

# ## Create some content
# echo -e "${YELLOW}Creating file with uppercase ${NO_COLOR}"
# echo 'text' > AAA.txt
# echo -e "${YELLOW}Trying to creating file with lowercase ${NO_COLOR}"
# echo 'text' > aaa.txt

# ls -la
# exit 1;
# ### Commit the changes
# git add AAA-folder/AAA-file.txt
# git commit -m "Added AAA-file.txt"

# ### Push the changes to the remote repository
# git push origin main

# ### Lets now change the folder name
# mv AAA-folder aaa-folder

# ## Let check the staging area for changes
# ##
# ## >>> No changes !!!
# git status

# ## List local files and directories
# echo "----------------------------------------------------"
# echo "Local files:"
# echo ""
# ls | grep *-folder

# ## List local files as they are "stored" in git
# echo "----------------------------------------------------"
# echo "Local git file names:"
# echo ""
# git ls-tree  main --name-only

# ## List remotes file and folders
# echo "----------------------------------------------------"
# echo "Remote files:"
# echo ""
# git ls-tree -r origin/main --name-only

# # Change the case flag to false so that git will trach the changes
# git config core.ignorecase false

# # Verify that now we see the changes
# echo "----------------------------------------------------"
# git status

# # Clear Demo folder
# rm -rf /tmp/remoteRepository
# rm -rf /tmp/localRepository
