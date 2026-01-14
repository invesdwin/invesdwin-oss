#! /bin/bash

cd "$(dirname "$0")"

if [ -z "$(ls -A invesdwin-bom)" ]
then
   ./pull_fallback.sh
fi

git pull
git submodule init

OUTER_BRANCH=$(git branch --show-current 2> /dev/null)
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
  if [ -z "$(ls -A .)" ]; then
    echo -- $moduleDir -- git submodule update --init --recursive --remote .
    git submodule update --init --recursive --remote .
    echo -- $moduleDir -- git checkout $OUTER_BRANCH
    git checkout $OUTER_BRANCH
  fi
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
    git stash -u
  fi
  BRANCH=$(git branch --show-current 2> /dev/null)
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
  if $(git rev-parse --is-shallow-repository); then
    echo -- $dir -- fetching shallow branches
    git remote set-branches origin '*'
    git fetch -v --depth=1
  fi
  if [ $LOCALCHANGES == 1 ]
  then
    echo -- $dir -- popping stash
    git stash pop
  fi
  cd ..
done

cd dependencies
./pull.sh

