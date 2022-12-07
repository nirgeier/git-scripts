#!/bin/bash

clear
# Load the colors script
source ../../_utils/colors.sh

### Define the desired filters.
### For the simplicity of the demo we use it inline
### In real life it can be any path to actual script

### The ip which we wish to use
### Inreal lifebe passowrd, ip or any other value
DB_IP_LOCAL=127.0.0.1
DB_IP_PROD=10.10.10.10

echo -e ""
echo -e "Pre-defined values:"
echo -e "------------------------------------------------"
echo -e "${Yellow}DB_IP_PROD:\t${Green}${DB_IP_LOCAL}${Color_Off}"
echo -e "${Yellow}DB_IP_PROD:\t${Green}${DB_IP_PROD}${Color_Off}"
echo -e ""

echo -e "${Cyan}* Creating\t demo repository${Color_Off}"
### Create the demo repository
rm -rf      /tmp/demo_smudge
mkdir -p    /tmp/demo_smudge
cd          /tmp/demo_smudge

# Generate the .env file
echo -e "${Cyan}* Initializing\t .env file${Color_Off}"
cat << EOF >> .env
## Database
##  * Local:      <Any Value>
##  * Production: 10.10.10.10
database.ip=0.0.0.0

## Feature1
feature1.env=DEV
feature1.key=f1-key
feature1.name=feature1
EOF

echo -e ""
echo -e "Current .env file content"
echo -e "------------------------------------------------"
echo -e "${Green}"
cat .env
echo -e "${Color_Off}"
echo -e "------------------------------------------------"
echo -e ""

### Init the empty repository
echo -e "${Cyan}* Initializing demo repository${Color_Off}"

## Init git repo
git init --quiet
# Add the demo remote repository
git remote add origin git@github.com:nirgeier/demo-git-smudge-clean.git

# Add all files
echo -e "${Cyan}* Adding content to demo repository${Color_Off}"
git add .

# Commit changes
echo -e "${Cyan}* Commiting content to demo repository${Color_Off}"
git commit -m"Initial Commit without smudge-clean" --quiet

echo -e "${Cyan}* Pushing content to demo repository${Color_Off}"
echo -e "${Yellow}git@github.com:nirgeier/demo-git-smudge-clean.git${Color_Off}"

git push --set-upstream origin main -f --quiet

echo -e "${Red}>>> Press any key to continue${Color_Off}"

# Wait for user input to continue (max timeout 600 seconds)
read -t 600 -n 1

### MacOS users should use gsed instead of sed

# Clean is applied when we add file to stage
echo -e "${Cyan}* Define clean filter${Color_Off}"
git config --local filter.cleanLocalhost.clean  "gsed -e 's/database.ip=.*/database.ip=${DB_IP_PROD}/g'"

# Smudge is applied when we checkout file
echo -e "${Cyan}* Define smudge filter${Color_Off}"
git config --local filter.cleanLocalhost.smudge "gsed -e 's/database.ip=*/database.ip=${DB_IP_LOCAL}/g'"

###  Define the filters 
echo -e "${Cyan}* Adding filters (smudge-clean) to demo repository${Color_Off}"
echo '.env text eol=lf filter=cleanLocalhost' > .gitattributes

### Commit the file again after we set up the filter
echo -e "${Cyan}* Adding second commit${Color_Off}"
echo 'Second Commit' >> README.md

echo -e "${Cyan}* Adding the same file (.env)${Color_Off}"
git add .

echo -e "${Cyan}* View the diff (.env)${Color_Off}"
echo -e "------------------------------------------------"
git --no-pager diff --cached .env
echo -e "------------------------------------------------"

echo -e "${Cyan}* Commit changes${Color_Off}"

git commit -m"Second commit with smudge-clean" --quiet
echo -e "${Cyan}* Pushing second commit to git${Color_Off}"
git push --set-upstream origin main --quiet

echo -e ""
echo -e "Current .env file content"
echo -e "------------------------------------------------"
echo -e "${Green}"
cat .env
echo -e "${Color_Off}"
echo -e "------------------------------------------------"
echo -e ""