#! /bin/bash

cd "$(dirname "$0")"

git pull
git submodule update --init --recursive --remote --rebase

OUTER_BRANCH=$(git branch --show-current)
if [ -z "$OUTER_BRANCH" ]
then
  OUTER_BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

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
  BRANCH=$(git branch --show-current)
  if [ -z "$BRANCH" ]
  then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
  fi
  if [ -z "$BRANCH" ]
  then
    BRANCH=$OUTER_BRANCH
  fi
  echo -- $moduleDir -- git checkout $BRANCH
  git checkout $BRANCH
  echo -- $dir -- pulling
  git pull
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- popping stash
    git stash pop
  fi
  cd ..
done

cd dependencies
./pull.sh

