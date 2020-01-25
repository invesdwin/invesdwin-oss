#! /bin/bash

for dir in *
do
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  echo -- $dir -- committing
  git commit
  cd ..
done
