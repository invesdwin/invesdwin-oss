#! /bin/bash

git pull
git submodule update --init --recursive --remote

for dir in ./*
do
  test -d "$dir" || continue
  cd $dir
  git stash
  STASHED=$?
  git checkout master
  git pull
  if [ $STASHED == 0 ] 
  then
    git stash pop
  fi
  cd ..
done


