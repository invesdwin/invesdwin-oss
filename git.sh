#! /bin/bash

cd "$(dirname "$0")"

git "$@"

for dir in *
do
  test "dependencies" = "$dir" && continue
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  echo -- $dir -- git "$@"
  git "$@"
  cd ..
done
