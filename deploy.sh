#!/bin/sh
git fetch
cd ./_site
git checkout origin/master
cd ..

msg=$(git log --oneline -1 | cat)
JEKYLL_ENV=production bundle exec jekyll build

cd ./_site
git add .
git commit -m "🚀 updated build to '$msg'"
git push origin HEAD:master
cd ..
