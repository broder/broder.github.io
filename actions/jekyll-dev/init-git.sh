#!/bin/sh
set -eux

git worktree add ./_site origin/master
cd ./_site
git checkout -f origin/master
