#! /bin/bash

git commit

for dir in *
do
  test "dependencies" = "$dir" && continue
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  echo -- $dir -- committing
  git commit
  cd ..
done

cd dependencies
./commit.sh
