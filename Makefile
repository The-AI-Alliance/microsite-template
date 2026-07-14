# Makefile for the REPO_NAME_MACRO code and GitHub pages website.
# See other project Makefiles for definitions for using Ollama, etc., etc.
# E.g., https://github.com/The-AI-Alliance/ai-application-testing/blob/main/Makefile

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

${CODE}make foobar${_END}         # Help on the foobar target (Please edit!)
endef

# Common includes. See the beginning of this file, too!
# The reason the following are put at the end, rather than the beginning, is to
# control the ordering of dependencies for "global" targets, like "help".
include .website.mk
