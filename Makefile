# Makefile for the REPO_NAME code and GitHub pages website.
# See other project Makefiles for definitions for using Ollama, etc., etc.
# E.g., https://github.com/The-AI-Alliance/ai-application-testing/blob/main/Makefile

# Environment variables
MAKEFLAGS             ?= --warn-undefined-variables
MAKEFLAGS_RECURSIVE   ?= # --print-directory (only useful for recursive makes...)
UNAME                 ?= $(shell uname)
ARCHITECTURE          ?= $(shell uname -m)

# Definitions for the website.
GITHUB_PAGES_URL      ?= https://the-ai-alliance.github.io/REPO_NAME/
DOCS_DIR              ?= docs
SITE_DIR              ?= ${DOCS_DIR}/_site
CLEAN_DOCS_DIRS       ?= ${SITE_DIR} ${DOCS_DIR}/.sass-cache

# Override when running `make view-local` using e.g., `JEKYLL_PORT=8000 make view-local`
JEKYLL_PORT           ?= 4000

# Used for version tagging of release artifacts, log file names, etc.
GIT_HASH              ?= $(shell git show --pretty="%H" --abbrev-commit |head -1)
TIMESTAMP             ?= $(shell date +"%Y%m%d-%H%M%S")

# Time execution
TIME                  ?= time  # time execution of long processes

# Source files location
SRC_DIR               ?= src

# Colored output using tput. Adapted from
# https://stackoverflow.com/a/53528374
# Posted by Robert Ranjan
# Retrieved 2026-05-18, License - CC BY-SA 4.0
# TIP: Run `make show-colors` (This target is at the end of this file.)

RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
ORANGE=$(shell tput setaf 3)
BLUE=$(shell tput setaf 4)
PINK=$(shell tput setaf 5)
DARK_GREEN=$(shell tput setaf 6)
LIGHT_GREY=$(shell tput setaf 7)
BLACK=$(shell tput setaf 8)
# virtually identical to RED:
RED2=$(shell tput setaf 9)
RESET=$(shell tput sgr0)

ERROR        = ${RED}ERROR:
WARN         = ${ORANGE}WARNING:
WARNING      = ${ORANGE}WARNING:
NOTE         = ${BLUE}NOTE:
INFO         = ${DARK_GREEN}INFO:
TIP          = ${BLUE}TIP:
HIGHLIGHT    = ${BLUE}

# TODO: If you aren't using GitHub Pages in the docs directory,
# delete the next three lines and all uses of DOCS_DIR.
# Similarly for the `src` directory...
ifndef DOCS_DIR
$(error ${ERROR} There is no ${DOCS_DIR} directory!${RESET})
endif
ifndef SRC_DIR
$(error ${ERROR} There is no ${SRC_DIR} directory!${RESET})
endif

define help_message
${BLUE}Quick help for this make process.${RESET}

${GREEN}make all${RESET}                # Clean and locally view the document.
${GREEN}make clean${RESET}              # Remove built artifacts, etc.
${GREEN}make view-pages${RESET}         # View the published GitHub pages in a browser.
${GREEN}make view-local${RESET}         # View the pages locally (requires Jekyll).
                        # Tip: "JEKYLL_PORT=8000 make view-local" uses port 8000 instead of 4000!

${BLUE}Miscellaneous tasks for help, debugging, setup, etc.${RESET}

${GREEN}make help${RESET}               # Prints this output.
${GREEN}make print-info${RESET}         # Print the current values of some make and env. variables.
${GREEN}make setup-jekyll${RESET}       # Install Jekyll. Make sure Ruby is installed. 
                        # (Only needed for local viewing of the document.)
${GREEN}make run-jekyll${RESET}         # Used by "view-local"; assumes everything is already built.
                        # ${TIP} "JEKYLL_PORT=8000 make run-jekyll" uses port 8000 instead of 4000!${RESET}
endef

define gem-error-message

ERROR: Did the gem command fail with a message like this?
ERROR:
ERROR: 	 "You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory."
ERROR: To run the "gem install ..." command for the MacOS default ruby installation requires "sudo".
ERROR: Instead, use Homebrew (https://brew.sh) to install ruby and make sure "/usr/local/.../bin/gem"
ERROR: is on your PATH before "user/bin/gem".
ERROR:
ERROR: Or did the gem command fail with a message like this?
ERROR:
ERROR:   Bundler found conflicting requirements for the RubyGems version:
ERROR:     In Gemfile:
ERROR:       foo-bar (>= 3.0.0) was resolved to 3.0.0, which depends on
ERROR:         RubyGems (>= 3.3.22)
ERROR:   
ERROR:     Current RubyGems version:
ERROR:       RubyGems (= 3.3.11)
ERROR:
ERROR: In this case, try "brew upgrade ruby@3.3.5" (or use whatever ruby manager
ERROR: you use) to get a newer version.
ERROR: 
ERROR: NOTE: At this time, Ruby 4.0+ aren't supported by GitHub Pages!
ERROR: If you instead see an error message like this:
ERROR: 
ERROR:   Resolving dependencies...
ERROR:   Could not find compatible versions
ERROR:   
ERROR:   Because github-pages >= 232 depends on jekyll-commonmark-ghpages = 0.5.1
ERROR:     and jekyll-commonmark-ghpages >= 0.2.0 depends on jekyll-commonmark ~> 1.4.0,
ERROR:     github-pages >= 232 requires jekyll-commonmark ~> 1.4.0.
ERROR:   And because jekyll-commonmark >= 1.4.0 depends on commonmarker ~> 0.22
ERROR:     and commonmarker >= 0.22.0, < 1.0.0.pre depends on Ruby >= 2.6, < 4.0,
ERROR:     github-pages >= 232 requires Ruby >= 2.6, < 4.0.
ERROR:   So, because Gemfile depends on github-pages ~> 232
ERROR:     and current Ruby version is = 4.0.3,
ERROR:     version solving has failed.
ERROR:
ERROR: This means you are trying to use Ruby 4.0+, which isn't supported by
ERROR: GitHub Pages! Use your Ruby management tool (eg., 'chruby', Homebrew, ...)
ERROR: to install a 3.X version, e.g., 3.3.5. Tools like 'chruby' let you install
ERROR: and use multiple versions of Ruby.

endef

define bundle-error-message

ERROR: Did the bundle command fail with a message like this?
ERROR:
ERROR: 	 "/usr/local/opt/ruby/bin/bundle:25:in `load': cannot load such file -- /usr/local/lib/ruby/gems/3.1.0/gems/bundler-X.Y.Z/exe/bundle (LoadError)"
ERROR:
ERROR: Check that the /usr/local/lib/ruby/gems/3.1.0/gems/bundler-X.Y.Z directory actually exists. 
ERROR:
ERROR: If not, try running the clean-jekyll command first:
ERROR:   make clean-jekyll setup-jekyll
ERROR: Answer "y" (yes) to the prompts and ignore any warnings that you can't uninstall a "default" gem.

endef

define ruby_installation_message
See ruby-lang.org for installation instructions.

WARNING: Install the latest Ruby version 3 release. 
WARNING: Version 4 releases aren't supported by GitHub Pages.
endef

.PHONY: all view-pages view-local clean help 
.PHONY: setup-jekyll run-jekyll

all:: view-local

help::
	$(info ${help_message})
	@echo

print-info:
	@echo "${GREEN}GitHub Pages URL${RESET}:    ${GITHUB_PAGES_URL}"
	@echo "${GREEN}current dir${RESET}:         ${PWD}"
	@echo "${GREEN}docs dir${RESET}:            ${DOCS_DIR}"
	@echo "${GREEN}site dir${RESET}:            ${SITE_DIR}"
	@echo "${GREEN}clean dirs${RESET}:          ${CLEAN_DOCS_DIRS} (deleted by 'make clean')"
	@echo
	@echo "${GREEN}MAKEFLAGS${RESET}:           ${MAKEFLAGS}"
	@echo "${GREEN}MAKEFLAGS_RECURSIVE${RESET}: ${MAKEFLAGS_RECURSIVE}"
	@echo "${GREEN}JEKYLL_PORT${RESET}:         ${JEKYLL_PORT}"
	@echo "${GREEN}UNAME${RESET}:               ${UNAME}"
	@echo "${GREEN}ARCHITECTURE${RESET}:        ${ARCHITECTURE}"
	@echo "${GREEN}GIT_HASH${RESET}:            ${GIT_HASH}"
	@echo "${GREEN}TIMESTAMP${RESET}:           ${TIMESTAMP}"

clean::
	rm -rf ${CLEAN_DOCS_DIRS} 

view-pages::
	@python -m webbrowser "${GITHUB_PAGES_URL}" || \
		$(error ${ERROR}: I could not open the GitHub Pages URL. Try ⌘-click or ^-click on this URL instead: ${GITHUB_PAGES_URL}${RESET})

view-local:: setup-jekyll run-jekyll

# Passing --baseurl '' allows us to use `localhost:4000` rather than require
# `localhost:4000/The-AI-Alliance/REPO_NAME` when running locally.
run-jekyll: clean
	@echo
	@echo "${TIP}Once you see the http://127.0.0.1:${JEKYLL_PORT}/ URL printed, open it with command+click...${RESET}"
	@echo
	cd ${DOCS_DIR} && \
		bundle exec jekyll serve --port ${JEKYLL_PORT} --baseurl '' --incremental || \
		${MAKE} jekyll-error

setup-jekyll:: ruby-installed-check ruby-gem-installation bundle-command-check bundle-installation

.PHONY: ruby-installed-check ruby-gem-installation bundle-command-check bundle-installation
.PHONY: jekyll-error ruby-missing-error gem-missing-error gem-error bundle-error bundle-missing-error

ruby-gem-installation::
	@echo "${INFO}Updating Ruby gems required for local viewing of the docs, including jekyll.${RESET}"
	gem install jekyll bundler jemoji || ${MAKE} gem-error

bundle-installation::
	bundle install || ${MAKE} bundle-error
	bundle update html-pipeline || ${MAKE} bundle-error

ruby-installed-check:
	@command -v ruby > /dev/null || ${MAKE} ruby-missing-error
	@command -v gem  > /dev/null || ${MAKE} gem-missing-error
	@ruby --version | grep -q 'ruby 3' || ${MAKE} ruby-version-error

bundle-command-check:
	@command -v bundle > /dev/null || \
		${MAKE} bundle-missing-error 

# NOTE: We call make to run these %-error targets, because if you try
# some_command || $(error "didn't work"), the $(error ...) function is always
# invoked, independent of the shell script logic. Hence, the only way to make
# this invocation conditional is to use a make target invocation, as shown above.
jekyll-error:
	$(error ${ERROR} Failed to run Jekyll. Try running 'make setup-jekyll'.${RESET})
ruby-missing-error:
	$(error ${WARNING} 'ruby' is required for running the GitHub Pages docs locally. ${ruby_installation_message}${RESET})
ruby-version-error: show-ruby-version
	$(error ${ERROR} The wrong version of 'ruby' was found. ${ruby_installation_message}${RESET})
show-ruby-version:
	@echo "${INFO}Ruby version found:${RESET}"
	@ruby --version
gem-missing-error:
	$(error ${ERROR} Ruby's 'gem' is required. ${ruby_installation_message}${RESET})
gem-error:
	$(error ${ERROR} ${gem-error-message}${RESET})
bundle-error:
	$(error ${ERROR} ${bundle-error-message}${RESET})
bundle-missing-error:
	$(error ${ERROR} Ruby gem command 'bundle' is required. I tried 'gem install bundle', but it apparently didn't work!${RESET})


# Use this target to see the colors defined above.
show-colors:
	$(info This is <${RED}RED${RESET}>)
	$(info This is <${RED2}RED2${RESET}>)
	$(info This is <${GREEN}GREEN${RESET}>)
	$(info This is <${ORANGE}ORANGE${RESET}>)
	$(info This is <${BLUE}BLUE${RESET}>)
	$(info This is <${PINK}PINK${RESET}>)
	$(info This is <${DARK_GREEN}DARK_GREEN${RESET}>)
	$(info This is <${LIGHT_GREY}LIGHT_GREY${RESET}>)
	$(info This is <${BLACK}BLACK${RESET}>)
