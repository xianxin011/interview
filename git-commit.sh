#!/bin/sh
set -e  # Exit on any error
# git add . && git commit -m "feat: add md" && git push origin master
git add .
if ! git diff --quiet --cached; then
  git commit -m "feat: add md"
  git push origin "$(git rev-parse --abbrev-ref HEAD)"
else
  echo "No changes to commit"
  exit 0
fi