#! /bin/bash

set -e

git pull
git submodule update --init --recursive --remote

for dir in ./*
do
  test -d "$dir" || continue
  cd $dir
  git stash
  git checkout master
  git pull
  git stash pop
  cd ..
done


