#!/bin/bash

clear

# Set the number of the desired commits
NUMBER_OF_COMMITS=1000

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

# Load the colors script
source ../_utils/colors.sh
source ../_utils/utils.sh

################################################################
### Demo Code to explain mv vs git mv
################################################################

# Crate a dummy repository
# Create the repository with first 1000 commits
generate_repository 10

# Add some dummy content
echo -e "${YELLOW}* Adding new files with lowercase ${NO_COLOR}"
echo -e "${CYAN}  * echo \$RANDOM > a.txt ${NO_COLOR}"
echo -e "${CYAN}  * echo \$RANDOM > b.txt ${NO_COLOR}"
echo $RANDOM > a.txt
echo $RANDOM > b.txt

# Commit the changes
echo -e "${YELLOW}* Add & commit changes ${NO_COLOR}"
git add .
git commit -q -m "Initial commit"

# Demo main code
echo -e "${YELLOW}---------------------------------------------------------------- ${NO_COLOR}"
echo -e "$     mv a.txt A1.txt"
echo -e "$ git mv b.txt B1.txt"
echo -e "${YELLOW}---------------------------------------------------------------- ${NO_COLOR}"

mv      a.txt A1.txt
git mv  b.txt B1.txt

echo -e "${YELLOW}* Check for changes ${NO_COLOR}"
echo -e " ${NO_COLOR}$ git status ${NO_COLOR}"
git status


