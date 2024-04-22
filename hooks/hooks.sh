#!/bin/bash

clear

# Set the number of the desired commits
NUMBER_OF_COMMITS=10

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

# Load the colors script
source ../_utils/colors.sh
source ../_utils/utils.sh

# Create the repository with first 1000 commits
generate_repository $NUMBER_OF_COMMITS

# Set hooks path
git config --local core.hooksPath $SCRIPT_DIR

# Demo main code
echo -e "${YELLOW}* Setting hooksPath configuration ${NO_COLOR}"
echo -e "${CYAN}  $ git config --local core.hooksPath $SCRIPT_DIR"
git config --local core.hooksPath $SCRIPT_DIR

echo -e "${YELLOW}* Adding ${YELLOW}a.txt ${NO_COLOR}"
echo 'a' > a.txt
git add .
git commit -q -m "No Secret"


echo -e "${YELLOW}* Adding ${YELLOW}secret.txt ${NO_COLOR}"
echo 'secret' >  secret.txt
git add .
git commit -q -m "Secret Added"













