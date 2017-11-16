#! /bin/bash

git push

for dir in *
do
  test "dependencies" = "$dir" && continue
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  echo -- $dir -- pushing
  git push
  cd ..
done

cd dependencies
./push.sh
