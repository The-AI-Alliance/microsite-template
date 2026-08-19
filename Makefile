# Makefile for the REPO_NAME_MACRO code and GitHub pages website.
# See other project Makefiles for definitions for using Ollama, etc., etc.
# E.g., https://github.com/The-AI-Alliance/ai-application-testing/blob/main/Makefile
# This project has a LOT of additional targets...

# Add custom help for the application here, which will be shown when the user
# types "make help".
# When you see ${CODE}${_END} without anything between them in help messages,
# it is there to make it easier to line up multi-line description comments.
# See for example the definition of help-message-general in .common.mk.

help::
	$(info ${help-custom-message})

define help-custom-message
${HIGHLIGHT} Quick help for this project's custom targets: ${_END}

${NOTE_LABEL} No custom targets are defined at this time.

endef

# The unit-tests task (which uses pytest) will fail (as written...) in
# .common.mk in the step where it runs the coverage report if there is
# no coverage because there were no tests found in the project. Delete
# the following override definition of unit-tests-command when tests
# are added to the project.
unit-tests-command:
	@echo "${skip-command-target-message}"
	@true

# Finally, include all the common targets, including those not overridden above
include .common.mk

