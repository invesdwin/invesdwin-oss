#! /bin/bash

cd "$(dirname "$0")"

git pull
#https://stackoverflow.com/questions/10168449/git-update-submodules-recursively
git submodule init
git submodule update
git submodule foreach 'git fetch origin; git checkout master || git checkout main; git submodule update --recursive'


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
  echo -- $dir -- checking out master
  git checkout master
  echo -- $dir -- pulling
  git pull
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- popping stash
    git stash pop
  fi
  cd ..
done

cd dependencies
./pull.sh

