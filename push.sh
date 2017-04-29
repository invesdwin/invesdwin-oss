#! /bin/bash

git push

for dir in *
do
  test -d "$dir" || continue
  cd $dir
  echo -- $dir -- pushing
  git push
  cd ..
done


