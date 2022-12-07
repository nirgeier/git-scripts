#!/bin/bash

clear
# Load the colors script
source ../_utils/colors.sh

# Disable git pager
git config --global --replace-all core.pager "less -F -X"

### Define the desired tags.
TAG1=v1.0
TAG2=v2.0

### Choose a random commit for tag1
RANDOM_COMMIT1=$(( ( $RANDOM % 15 )  + 10 ))

### Choose a random commit for tag2
RANDOM_COMMIT2=$(( ( $RANDOM % 15 )  + 10 ))

echo -e ""
echo -e "Pre-defined tags:"
echo -e "------------------------------------------------"
echo -e "${Yellow}TAG1:\t${Green}${TAG1} -> ${RANDOM_COMMIT1}${Color_Off}"
echo -e "${Yellow}TAG2:\t${Green}${TAG2} -> ${RANDOM_COMMIT2}${Color_Off}"
echo -e ""

echo -e "${Cyan}* Creating\t demo repository${Color_Off}"
### Create the demo repository
rm -rf      /tmp/demo_tags
mkdir -p    /tmp/demo_tags
cd          /tmp/demo_tags

## Init git repo
git init --quiet

## Add few commits
for i in {10..25}
do
    # Create the dummy file(s)
    touch ./file_${i}.txt
    # Add and commit the files
    git add . && git commit -q -m"File #${i}"
    # Add tag if its the first commit
    if [ "$i" -eq "$RANDOM_COMMIT1" ]; 
    then
        git tag $TAG1
    fi

    # Add annotataed tag if its the first commit
    if [ "$i" -eq "$RANDOM_COMMIT2" ]; 
    then
        git tag -a $TAG2 -m"Made by script (Commit #${i})"
    fi
done

echo -e ""
echo -e "Disaply tags:"
echo -e "------------------------------------------------"
echo -e "${Yellow}TAG1:\t${Green}${TAG1} -> ${RANDOM_COMMIT1}${Color_Off}"
echo -e ""
git show $TAG1
echo -e "------------------------------------------------"
echo -e "${Yellow}TAG2:\t${Green}${TAG2} -> ${RANDOM_COMMIT2}${Color_Off}"
echo -e ""
git show $TAG2
