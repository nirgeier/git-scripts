#!/bin/bash

clear
# Set the tabs space
tabs 2

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

# Load the colors script
source ../_utils/colors.sh
source ../_utils/utils.sh

###
### Merge conflict demo
###

# Create a new demo repository
rm -rf   /tmp/tempRepository
echo -e ""
echo -e "${YELLOW}* Preparation(s) ${NO_COLOR}"
echo -e "${GREEN}\t* Initialized empty Git repository ${NO_COLOR}"

mkdir       -p  /tmp/tempRepository > /dev/null
git init    -q  /tmp/tempRepository 
cd              /tmp/tempRepository 

echo -e "${GREEN}\t* Creating branchA ${NO_COLOR}"
# Create a new branch
git checkout -q -b branchA > /dev/null

# Add some content to it
echo -e "${GREEN}\t* Adding content ot branchA ${NO_COLOR}"
echo  "Hello World" > fileA.txt
git   add .
git   commit -q -m "Initial commit - branchA"

# Create a new branch from branchA
echo -e "${GREEN}\t* Create ${RED}branchB${GREEN} from ${RED}branchA${GREEN}"
git branch branchB

echo -e "${YELLOW}* Generating conflict ${NO_COLOR}"
echo -e "${GREEN}\t* branchA: ${CYAN}echo \$RANDOM > random.txt ${NO_COLOR}"
git     checkout -q branchA
echo    $RANDOM > random.txt
git     add .
git     commit -q -m "$(git rev-parse --abbrev-ref HEAD) - Random commit"

echo -e "${GREEN}\t* branchB: ${CYAN}echo \$RANDOM > random.txt ${NO_COLOR}"
git     checkout -q branchB
echo    $RANDOM > random.txt
git     add .
git     commit -q -m "$(git rev-parse --abbrev-ref HEAD) - Random commit"

echo -e "${YELLOW}\t* Compare branches ${NO_COLOR}"
echo -e "${YELLOW}------------------------------------------------------------------------- ${NO_COLOR}"
git     diff branchA branchB
echo -e "${YELLOW}------------------------------------------------------------------------- ${NO_COLOR}"

# Wait for user input
echo "Press any key to continue..."
read -n 1

# Merge branchB into branchA with squash
echo -e "${YELLOW}* Merging (Conflict) ${NO_COLOR}"
git checkout -q branchA > /dev/null
git merge branchB
git merge branchB

echo -e "${RED}------------------------------------------------------------------------- ${NO_COLOR}"
echo -e "${RED}Fix conflicts ${NO_COLOR}"
echo -e "${RED}Repository folder: $(pwd)  ${NO_COLOR}"
echo -e "${RED}------------------------------------------------------------------------- ${NO_COLOR}"
