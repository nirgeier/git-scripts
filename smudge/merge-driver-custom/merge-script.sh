#!/bin/bash

Color_Off='\033[0m'       # Text Reset
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo -e ""
echo -e "------------------------------------------------"
echo -e "${Yellow}* Executing merge script${Color_Off}"
echo ""

echo -e "${Green}Ancestor: ${Color_Off}"
cat $1
echo -e "------------------------------------------------"

echo -e "${Green}Current: ${Color_Off}"
cat $2
echo -e "------------------------------------------------"

echo -e "${Green}Other: ${Color_Off}"
cat $3
echo -e "------------------------------------------------"

echo -e "${Yellow}* Resolving conflict as you wish${Color_Off}"
echo -e "${Yellow}  By assigninig the the desired resolution to [%A] ${Color_Off}"
echo "Resolved with this string" > $2 
echo -e "${Yellow}* Conflict resolved!${Color_Off}"

echo -e "${Green}Resolution: ${Color_Off}"
cat $2
echo -e "------------------------------------------------"

exit 0