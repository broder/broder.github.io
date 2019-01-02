#!/bin/sh
set -eux

if [ "$GITHUB_REF" = "refs/heads/$1" ]; then
  exit 0
else
  exit 1
fi
