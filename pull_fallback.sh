#! /bin/bash

cd "$(dirname "$0")"

git pull
git submodule update --init
git submodule foreach 'git fetch origin; git checkout master || git checkout main || git checkout development; git submodule update --init --recursive; git pull'
