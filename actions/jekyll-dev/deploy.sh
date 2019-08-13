#!/bin/sh
set -eux

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

set +x
if [ "${GITHUB_TOKEN+x}" ]; then
  echo "Adding remote origin push permissions..."
  git remote set-url origin "https://broder:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
fi
set -x

bundle exec rake deploy
