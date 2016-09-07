#! /bin/bash

git pull
git submodule update --init --recursive --remote

for dir in *
do
  test -d "$dir" || continue
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


