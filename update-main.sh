#!/usr/bin/env zsh
#------------------------------------------------------------------------
# A simple script that merges the latest work from "main" to "main",
# pushes the updates upstream, then switches back to "main" again.
# This is mostly useful if you tend to work in "main", so updates are
# published immediately, and you periodically want to update "main".
#
# NOTE: finish-microsite.sh deletes this file form the repo if a separate
# publication branch is not used.
#------------------------------------------------------------------------

git checkout main
git pull
git push  # make sure main has been pushed upstream
git checkout main
git pull
git merge main
git push
git checkout main # end with main checked out
