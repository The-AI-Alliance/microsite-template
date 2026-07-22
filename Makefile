# Makefile for the REPO_NAME_MACRO code and GitHub pages website.
# See other project Makefiles for definitions for using Ollama, etc., etc.
# E.g., https://github.com/The-AI-Alliance/ai-application-testing/blob/main/Makefile
# This project has a LOT of additional targets...

# Common includes. See the end of this file, too!
include .common.mk


# Add custom help for the application here, which will be shown when the user
# types "make help".
# When you see ${CODE}${_END} without anything between them in help messages,
# it is there to make it easier to line up multi-line description comments.

.PHONY: help-custom

help:: help-custom
help-custom::
	$(info ${help-custom-message})

define help-custom-message
${HIGHLIGHT}Quick help for this project's specific targets:${_END}

${BOLD}None defined at this time.${_END}

endef

# The pytest task will fail (as written...) when it runs the coverage
# report if there is no coverage because there were no tests. Delete
# the following override definition of unit-tests-default when tests
# are added to the project. (Ignore warnings about overriding the
# definition that you will see in the meantime!)
unit-tests-default:
	@echo "${skip-contrib-target}"
	@true

# Common includes. See the beginning of this file, too!
# The reason the following are put at the end, rather than the beginning, is to
# control the ordering of dependencies for "global" targets, like "help".
include .website.mk
