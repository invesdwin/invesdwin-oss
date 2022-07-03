#! /bin/bash

for dir in *
do
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
  if [ $dir == "fast-serialization" ]
  then
    git switch -c java8backport origin/java8backport
    git checkout java8backport
  
  else
    git checkout $(git rev-parse --abbrev-ref HEAD)
  fi
  echo -- $dir -- pulling
  git pull
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- popping stash
    git stash pop
  fi
  cd ..
done
