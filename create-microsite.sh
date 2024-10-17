#!/usr/bin/env zsh
#------------------------------------------------------------------------
# Convert this microsite template into your desired microsite.
# Run create-microsite.sh -h to see the required arguments and options.
#------------------------------------------------------------------------
set -e

tsformat="%Y-%m-%d %H:%M %z"
script=$0
dir=$(dirname $script)
cfg="$dir/docs/_config.yml"
index="$dir/docs/index.markdown" 
work_branch=main
publish_branch=latest

help() {
	cat << EOF
$script [-h|--help] [-n|--noop] repo-name microsite-title

Where the options and required arguments are the following:
-h | --help            Print this message and exit
-n | --noop            Just print the commands but don't make changes.
repo-name              (Required) the name of gitHub repo. See example below.
microsite-title        (Required) the title of microsite. See example below.

For example, suppose you want to create a microsite with the title "AI for Evil Project",
use the following the command:

$script ai-for-evil-project "AI for Evil Project"

Note that the title needs to be quoted!!
EOF
}

error() {
	for arg in "$@"
	do
		echo "ERROR ($script): $arg"
	done
	help
	exit 1
}

info() {
	for arg in "$@"
	do
		echo "INFO ($script): $arg"
	done
}

while [[ $# -gt 0 ]]
do
	case $1 in
		-h|--h*)
			help
			exit 0
			;;
		-n|--n*)
			NOOP=echo
			;;
		*)
			if [[ -z "$repo_name" ]]
			then
				repo_name="$1"
			elif [[ -z "$microsite_title" ]]
			then
				microsite_title="$1"
			else
				error "Unrecognized argument: $1"
			fi
			;;
	esac
	shift
done

missing=()
[[ -z "$repo_name" ]] && missing+=("The repo name is required. ")
[[ -z "$microsite_title" ]] && missing+=("The microsite title is required. ")
[[ ${#missing[@]} > 0 ]] && error "${missing[@]}"

info "Creating a microsite:"
info "  Repo name: $repo_name"
info "  Title:     $microsite_title"

#upstream_repo=microsite-template
upstream_repo="trust-safety-evals"       ## FIXME!!
targz=microsite-template.tar.gz
info "Downloading $targz..."
if [[ -z $NOOP ]]
then 
	curl -L https://api.github.com/repos/The-AI-Alliance/$upstream_repo/tarball > $targz
else
	$NOOP "curl -L https://api.github.com/repos/The-AI-Alliance/$upstream_repo/tarball > $targz"
fi
$NOOP tar xzf $targz
$NOOP rm $targz

# The directory should only 
for dir in *${upstream_repo}*
do
	info "Renaming $dir to $repo_name:"
	$NOOP mv $dir $repo_name
done

info "Replacing macro placeholders with values:"
[[ -z "$timestamp" ]] && timestamp=$(date +"$tsformat")
date -j -f "$tsformat" +"$tsformat" "$timestamp" > /dev/null 2>&1
[[ $? -ne 0 ]] && error "Invalid timestamp format for timestamp: $timestamp" "Required format: $tsformat"

$NOOP cd $repo_name

files=(
	Makefile
	docs/_config.yml
	README.md
	publish-website.sh
)
markdown_files=($(find docs -name '*.markdown'))
html_files=($(find docs/_layouts -name '*.html'))

info "Replacing macros with correct values:"
info "  REPO_NAME:       $repo_name"
info "  MICROSITE_TITLE: $microsite_title"
info "  TIMESTAMP:       $timestamp"
info "Files:"

for file in "${files[@]}" "${markdown_files[@]}" "${html_files[@]}"
do
	info "  $file"
	$NOOP mv $file $file.back
	if [[ -z $NOOP ]]
	then 
		# FIXME!!
		#m4 --define=REPO_NAME="$repo_name" --define=MICROSITE_TITLE="$microsite_title" --define=TIMESTAMP="$timestamp" $file.back > $file
		echo "m4 --define=REPO_NAME="$repo_name" --define=MICROSITE_TITLE="$microsite_title" --define=TIMESTAMP="$timestamp" $file.back > $file"
	else
		$NOOP "m4 --define=REPO_NAME="$repo_name" --define=MICROSITE_TITLE="$microsite_title" --define=TIMESTAMP="$timestamp" $file.back > $file"
	fi
done

info "Initialize $repo_name as a git repo and add all the files to it:"
$NOOP git init
$NOOP git add * .gitignore docs/.*
$NOOP git commit -m 'Initial commit for repo $repo_name'


info <<EOF

Done! The current working directory is $PWD.

Next Steps:

1. Go to https://github.com/The-AI-Alliance and create a repo named "$repo_name". 
   If you don't have permissions, as Dean Wampler, Adam Pingel, Joe Olson, or Trevor Grant to do this.
2. Follow the instructions given for adding a remote location to your local repo.
   If someone else creates the repo for you, remind them to give you the instructions!
3. Push your local content up to the remote repo!
EOF
