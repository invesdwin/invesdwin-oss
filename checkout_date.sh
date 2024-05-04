#! /bin/bash

cd "$(dirname "$0")"

#DATE='2022-08-01 00:00:00'
DATE="$1"

for dir in *
do
  test "dependencies" = "$dir" && continue
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
if [[ `git status --porcelain` ]]; then
  # changes
  LOCALCHANGES=1
else
  # no changes
  LOCALCHANGES=0
fi
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- stashing
    git stash
  fi
  REV=$(git rev-list -n 1 --before="$DATE" main)
  echo -- $dir -- checking out "$DATE" as "$REV"
  git checkout $REV
  echo -- $dir -- pulling
  git pull
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- popping stash
    git stash pop
  fi
  cd ..
done
