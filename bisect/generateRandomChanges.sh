#!/bin/bash

echo -e ""
echo -e "${Yellow}How many files to generate: [default: 3]${Color_Off}"
read count
if [ -z "$count" ];
then
    count=3
fi
typeset -i count
if [ "$count" -lt 1 ];
then
    echo -e "${Red}Please set number greater then 0"
    exit
fi

echo -en "${Yellow}Type the file name that you want to use: [default: random]${Color_Off}"
read filenamebase
if [ -z "$filenamebase" ]; 
then 
    filenamebase='random'
fi

echo -en "${Yellow}Type the file extention that you want to use: [default: txt]${Color_Off}"
read filenameextension
if [ -z "$filenameextension" ];   
then 
    filenameextension='txt'
fi

echo -e "${Green}Creating [$count] files. ${Color_Off}"
for (( filenumber = 1; filenumber <= $count ; filenumber++ )); 
    do
        echo -e "${Green}Writing to: $filenamebase$filenumber.$filenameextension ${Color_Off}"
        echo "Some new random text: $RANDOM" >> $filenamebase$filenumber.$filenameextension
        git add $filenamebase$filenumber.$filenameextension
        echo -e "${Green}Commiting changes${Color_Off}"
        git commit -m"A random change of $RANDOM to $filenamebase$filenumber.$filenameextension" --quiet
    done
echo