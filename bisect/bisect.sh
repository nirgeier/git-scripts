### Build the repo for bisect
rm -rf mkdir bisect
mkdir bisect
cd bisect

git init
../../generateRandomChanges 
../../generateRandomContent 
echo 'Here is the bug.' >> random3.txt
git add . && git commit -m "The bug is in this commit"
../../generateRandomContent 

echo 'Number of commits: ' . $(git rev-list --all --count)

###
echo 'Start the bisect'
git bisect good HEAD~2000
git bisect bad HEAD
git bisect run ../bisectScript.sh










