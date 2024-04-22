#!/bin/bash

# Load the colors script
source ../../_utils/colors.sh

###
### This is our demo script for searching the bug
### In this demo we simply search for a string
### In real life we can do a build, check who deleted file etc. 
###

grep "Here is the bug" random1.txt

if [ "$?" -eq "0" ]; then
    echo -e "${GREEN}Text found.${NO_COLOR}"
    exit 1
else
    #echo "Text not found."
    echo -e "${Red}Text Not found.${Color_Off}"
    exit 0
fi

echo ""