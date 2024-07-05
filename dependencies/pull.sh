#! /bin/bash

OUTER_BRANCH=$(git branch --show-current 2> /dev/null)
if [ -z "$OUTER_BRANCH" ]
then
  OUTER_BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

for dir in *
do
  test -d "$dir" || continue
  echo -- $dir
  cd $dir
  if [ -z "$(ls -A .)" ]; then
    echo -- $moduleDir -- git submodule update --init --recursive --remote .; git checkout master || git checkout development;
    git submodule update --init --recursive --remote .; git checkout master || git checkout main || git checkout development;
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
    git stash
  fi
  if [ $dir == "fast-serialization" ]
  then
    echo -- $dir -- git checkout java8backport
    git switch -c java8backport origin/java8backport
    git checkout java8backport
  else
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
  fi
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
