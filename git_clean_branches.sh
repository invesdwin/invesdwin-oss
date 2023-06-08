#!/usr/bin/env bash

# switch all submodules to the main branch
OUTER_BRANCH=$(git branch --show-current)
if [ -z "$OUTER_BRANCH" ]
then
  OUTER_BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

git remote prune origin
git branch -r --merged | egrep -v "(^\*|main|master)" | xargs -n 1 git push --delete origin
git branch --merged | egrep -v "(^\*|main|master)" | xargs git branch -d

for dir in *
do
  test "dependencies" = "$dir" && continue
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  if [[ `git status --porcelain` ]]; then
    # changes
    LOCALCHANGES=1
  else
    # no changes
    LOCALCHANGES=0
  fi
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- stashing
    git stash
  fi
  if [ `git branch --list $OUTER_BRANCH` ]
  then
    BRANCH=$OUTER_BRANCH
  else
    #https://stackoverflow.com/a/68098145
    BRANCH=$(git branch -l master main | sed -r 's/^[* ] //' | head -n 1)
  fi
  echo -- $moduleDir -- git checkout $BRANCH
  git checkout $BRANCH
  echo -- $dir -- pulling
  git pull
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- popping stash
    git stash pop
  fi
  # delete unneeded local and remote branches (https://devconnected.com/how-to-clean-up-git-branches/)
  git remote prune origin
  git branch -r --merged | egrep -v "(^\*|main|master)" | xargs -n 1 git push --delete origin
  git branch --merged | egrep -v "(^\*|main|master)" | xargs git branch -d
  cd ..
done
