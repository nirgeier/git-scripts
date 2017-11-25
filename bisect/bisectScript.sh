#!/bin/sh

grep "Here is the bug" random3.txt

if [ "$?" -eq "0" ]; then
    #echo "Text found."
    exit 1
else
    #echo "Text not found."
    exit 0
fi