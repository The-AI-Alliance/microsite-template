#!/usr/bin/env zsh
#------------------------------------------------------------------------
# A simple script that merges the latest work from "PUBLISH_BRANCH_MACRO" to "main",
# pushes the updates upstream, then switches back to "PUBLISH_BRANCH_MACRO" again.
# This is mostly useful if you tend to work in "PUBLISH_BRANCH_MACRO", so updates are
# published immediately, and you periodically want to update "main".
#
# NOTE: finish-microsite.sh deletes this file form the repo if a separate
# publication branch is not used.
#------------------------------------------------------------------------

git checkout PUBLISH_BRANCH_MACRO
git pull
git push  # make sure PUBLISH_BRANCH_MACRO has been pushed upstream
git checkout main
git pull
git merge PUBLISH_BRANCH_MACRO
git push
git checkout PUBLISH_BRANCH_MACRO # end with PUBLISH_BRANCH_MACRO checked out
