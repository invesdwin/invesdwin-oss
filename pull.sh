#! /bin/bash

git pull
git submodule update --init --recursive --remote

for dir in ./*
do
  test -d "$dir" || continue
  cd $dir
  git stash
  $stashed = $?
  git checkout master
  git pull
  if [ $stashed -eq 0 ] then
    git stash pop
  fi
  cd ..
done


