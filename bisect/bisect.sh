#!/bin/bash

clear

# Set the number of the desired commits
NUMBER_OF_COMMITS=1000

# Load the colors script
source ../_utils/colors.sh

echo -e "${Cyan}* Creating demo repository${Color_Off}"

### Build the repo for bisect
rm -rf  bisect-demo
mkdir   bisect-demo
cd      bisect-demo

echo -e "${Cyan}* Initializing demo git repository${Color_Off}"
git init --quiet

echo -e "${Cyan}* Randomize repository content with the first ${Yellow}$NUMBER_OF_COMMITS ${Cyan}commits${Color_Off}"
#. ../generateRandomChanges.sh
. ../generateRandomContent.sh $NUMBER_OF_COMMITS

echo -e "${Cyan}* Adding the 'bug' to the code [${Yellow}'Here is the bug.'${Cyan}]${Color_Off}"
echo 'Here is the bug.' >> random1.txt
echo -e "${Cyan}* Commiting the bug${Color_Off}"
git add . 
git commit -m "The bug is in this commit" --quiet

echo -e "${Yellow}-----------------------------------------${Color_Off}"
echo -e "${Green}The SHA-1 of the commit with the bug: ${Color_Off}"
echo -e "${Yellow}$(git rev-parse HEAD) ${Color_Off}"
echo -e "${Yellow}-----------------------------------------${Color_Off}"

echo -e "${Cyan}* Randomize repository content with more commits ${Yellow}$NUMBER_OF_COMMITS${Cyan} commits ${Color_Off}"
. ../generateRandomContent.sh $NUMBER_OF_COMMITS


TOTAL_NUMBER_OF_COMMIT=$(git rev-list --all --count)
echo -e "${Yellow}* Number of commits: ${Green}" $TOTAL_NUMBER_OF_COMMIT ${Color_Off}
echo -e "${Cyan}* Starting bisect ${Color_Off}"
echo -e ""
git bisect good HEAD~$((TOTAL_NUMBER_OF_COMMIT-1))
echo -e ""
git bisect bad HEAD

echo -e "${Cyan}* Searching for the bug ${Color_Off}"
echo -e ""
git bisect run ../bisectScript.sh










