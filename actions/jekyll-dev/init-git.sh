#!/bin/sh
set -eux

git worktree add ./_site origin/deploy
cd ./_site
git checkout -f origin/deploy
