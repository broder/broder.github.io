#!/bin/sh
rm -rf ./_site
git worktree prune
git fetch
msg=$(git log --oneline -1 | cat)
git worktree add ./_site origin/master
bundle exec jekyll build
cd ./_site
git add .
git commit -m "Updated build to '$msg'"
git push origin HEAD:master
cd ..
