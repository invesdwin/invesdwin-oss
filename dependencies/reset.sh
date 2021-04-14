#! /bin/bash

for dir in *
do
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  echo -- $dir -- resetting to master
  git reset --hard
  cd ..
done
