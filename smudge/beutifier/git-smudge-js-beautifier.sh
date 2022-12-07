#!/bin/bash

clear
rm -rf ~/workspace/tmp/git-demo1
git init ~/workspace/tmp/git-demo1
cd ~/workspace/tmp/git-demo1
git remote add origin git@github.com:nirgeier/githubDayDemo1.git

echo 'This is the default commit message' > .gitmessage.txt
git config commit.template .gitmessage.txt
git add .gitmessage.txt
git commit -m "Commited intial files"

sudo npm install -g js-beautify
git add .gitattributes
git config --local filter.jsbeautify.clean "js-beautify -f -"
git config --local filter.jsbeautify.smudge cat
echo '*.js filter=jsbeautify' > .gitattributes

wget http://code.jquery.com/jquery-migrate-1.4.1.js
echo '/n/n'
cat jquery-migrate-1.4.1.js | colrm 100

git add .

echo '/n/n'
cat jquery-migrate-1.4.1.js | colrm 100:q!

git commit -m "Commited beutified code"
git push origin master -f

