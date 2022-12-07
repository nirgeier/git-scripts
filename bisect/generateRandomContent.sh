#!/bin/bash

# Set the number of teh desired commits
NUMBER_OF_COMMITS=${1:-1000}

# Set the counter
FIRST_COMMIT=$(git rev-list --all --count)
LAST_COMMIT=$(($FIRST_COMMIT+$NUMBER_OF_COMMITS))

for (( filenumber = $FIRST_COMMIT; filenumber <= $LAST_COMMIT ; filenumber++ ));
do
    echo -ne "\r\033[K${Green}Commit # $(printf "%04d" ${filenumber})/${LAST_COMMIT} - ${Yellow}$(($filenumber*100/$LAST_COMMIT))%${Color_Off}"
    echo -en "Some new random text: $RANDOM" > random1.txt
    git add .
    git commit -m"A random change of $RANDOM" --quiet
done
echo 


