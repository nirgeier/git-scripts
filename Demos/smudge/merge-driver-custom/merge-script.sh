#!/bin/bash

NO_COLOR='\033[0m'       # Text Reset
Green='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # YELLOW

echo -e ""
echo -e "------------------------------------------------"
echo -e "${YELLOW}* Executing merge script${NO_COLOR}"
echo ""

echo -e "${GREEN}Ancestor: ${NO_COLOR}"
cat $1
echo -e "------------------------------------------------"

echo -e "${GREEN}Current: ${NO_COLOR}"
cat $2
echo -e "------------------------------------------------"

echo -e "${GREEN}Other: ${NO_COLOR}"
cat $3
echo -e "------------------------------------------------"

echo -e "${YELLOW}* Resolving conflict as you wish${NO_COLOR}"
echo -e "${YELLOW}  By assigninig the the desired resolution to [%A] ${NO_COLOR}"
echo "Resolved with this string" > $2 
echo -e "${YELLOW}* Conflict resolved!${NO_COLOR}"

echo -e "${GREEN}Resolution: ${NO_COLOR}"
cat $2
echo -e "------------------------------------------------"

exit 0