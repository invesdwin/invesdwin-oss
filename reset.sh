#! /bin/bash

git reset --hard

for dir in *
do
  test "dependencies" = "$dir" && continue
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  echo -- $dir -- resetting to master
  git reset --hard
  cd ..
done

cd dependencies
./reset.sh

