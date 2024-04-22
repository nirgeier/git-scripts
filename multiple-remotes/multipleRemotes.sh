#!/bin/bash

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

# Load the colors script
source ../_utils/colors.sh
source ../_utils/utils.sh

GIT_REPOS=(
  "/tmp/git-demo-remoteA"
  "/tmp/git-demo-remoteB"
  "/tmp/git-demo-remoteC"
)

# Cleaup prevoius reqpositories
for repo in "${GIT_REPOS[@]}"; 
do
  echo -e "${YELLOW}* Cleaning up ${repo} ${NO_COLOR}"
  rm -rf $repo

  # Create the required git repositories
  echo -e "${YELLOW}* Creating the required repositories ${NO_COLOR}"
  git init -q $repo 

  # Add a remote to the first repository
  echo -e "${YELLOW}* Commit code to $repo ${NO_COLOR}"
  cd    $repo
  echo  $RANDOM > $RANDOM.txt
  git   add . 
  git   commit -q -m "Initial commit $repo" 
done


# Add a second remote to the second repository
echo -e "${YELLOW}* List remotes in: /tmp/git-demo-remoteA ${NO_COLOR}"
cd      /tmp/git-demo-remoteA
git remote add remoteB /tmp/git-demo-remoteB
git remote add remoteC /tmp/git-demo-remoteC
git remote -v

echo -e "${YELLOW}* Fetch all remotes ${NO_COLOR}"
echo -e "${RED}---------------------------------------------------------------- ${GREEN}"
git fetch --all
echo -e "${RED}---------------------------------------------------------------- ${GREEN}"

echo -e ""
echo -e "${YELLOW}* List all Branches ${NO_COLOR}"
echo -e "${RED}---------------------------------------------------------------- ${NO_COLOR}"
git branch -a
echo -e "${RED}---------------------------------------------------------------- ${NO_COLOR}"

echo -e "${YELLOW}* Pull Commits from different remotes ${NO_COLOR}"
cd /tmp/git-demo-remoteB
remoteB=$(git rev-parse HEAD)
echo -e "${CYAN}  * Latest commit on remoteB [${YELLOW}$remoteB${CYAN}]${NO_COLOR}"

cd /tmp/git-demo-remoteC
remoteC=$(git rev-parse HEAD)
echo -e "${CYAN}  * Latest commit on remoteC [${YELLOW}$remoteC${CYAN}]${NO_COLOR}"

echo -e "${YELLOW}* Pull remoteB commit to remoteA ${NO_COLOR}"
cd      /tmp/git-demo-remoteA
git cherry-pick $remoteB >> /dev/null

echo -e "${YELLOW}* Pull remoteB commit to remoteC ${NO_COLOR}"
cd      /tmp/git-demo-remoteA
git cherry-pick $remoteC >> /dev/null

echo -e "${YELLOW}* List commit on remoteA ${NO_COLOR}"
cd      /tmp/git-demo-remoteA
echo -e "${RED}---------------------------------------------------------------- ${NO_COLOR}"
git log --oneline --graph --decorate
echo -e "${RED}---------------------------------------------------------------- ${NO_COLOR}"

