#!/usr/bin/env zsh
#------------------------------------------------------------------------
# Convert this microsite template into your desired microsite.
# Run create-microsite.sh -h to see the required arguments and options.
#------------------------------------------------------------------------
set -e

ymdformat="%Y-%m-%d"
tsformat="$ymdformat %H:%M %z"
script=$0
dir=$(dirname $script)
cfg="$dir/docs/_config.yml"
index="$dir/docs/index.markdown" 
work_branch=main
publish_branch=latest

declare -A fa_names
fa_names["FA1"]="FA1: Skills and Education"
fa_names["FA2"]="FA2: Trust and Safety"
fa_names["FA3"]="FA3: Applications and Tools"
fa_names["FA4"]="FA4: Hardware Enablement"
fa_names["FA5"]="FA5: Foundation Models and Datasets"
fa_names["FA6"]="FA6: Advocacy"

declare -A fa_url_names
fa_url_names["FA1"]=skills-education
fa_url_names["FA2"]=trust-and-safety
fa_url_names["FA3"]=applications-and-tools
fa_url_names["FA4"]=hardware-enablement
fa_url_names["FA5"]=foundation-models
fa_url_names["FA6"]=advocacy

help() {
	cat << EOF
$script [-h|--help] [-n|--noop] [--ns|--next-steps] \ 
  --repo-name|-r name --microsite-title|--site-title|-t title --work-group|-w work_group

Where the options and required arguments are the following:
-h | --help            Print this message and exit.
-n | --noop            Just print the commands but don't run them.
-s | --next-steps      At the end of running this script to create a new repo,
                       some information about "next steps" is printed. If you want to see
                       this information again, run this script again just using this flag.

These arguments are required, but they can appear in any order. See the example below:

--repo-name | -r name  The name of gitHub repo.
--microsite-title | --site-title | -t title
                       The title of the microsite. 
--work-group | -w work_group
                       The name of work group sponsoring this site.

For example, suppose you want to create a microsite with the title "AI for Evil Project",
under the FA2: Trust and Safety work group, then use the following the command:

$script --repo-name ai-for-evil-project --microsite-title "AI for Evil Project" --work-group fa2

Note that just specifying "fa1" or "FA1", etc. for any of the focus areas will result in the 
following names being used:

FA1: ${fa_names["FA1"]}
FA2: ${fa_names["FA2"]}
FA3: ${fa_names["FA3"]}
FA4: ${fa_names["FA4"]}
FA5: ${fa_names["FA5"]}
FA6: ${fa_names["FA6"]}

NOTE: The title and work group strings need to be quoted if they contain spaces!
EOF
}

next_steps() {
	cat << EOF

Next Steps:

Return to the microsite-template README and continue at step "2. Create an Upstream Repo"

  https://github.com/The-AI-Alliance/microsite-template/blob/main/README.md#2-create-an-upstream-repo

To see these instructions again, run the following command:

  $script --next-steps
EOF
}

error() {
	for arg in "$@"
	do
		echo "ERROR ($script): $arg"
	done
	echo "ERROR: Try: $script --help"
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
		-s|--next-steps)
			next_steps
			exit 0
			;;
		--repo-name|-r)
			shift
			repo_name="$1"
			;;
		--microsite-title|--site-title|-t)
			shift
			microsite_title="$1"
			;;
		--work-group|-w)
			shift
			case $1 in				
				fa1|FA1)
					work_group=${fa_names["FA1"]}
					work_group_url=${fa_url_names["FA1"]}
					;;
				fa2|FA2)
					work_group=${fa_names["FA2"]}
					work_group_url=${fa_url_names["FA2"]}
					;;
				fa3|FA3)
					work_group=${fa_names["FA3"]}
					work_group_url=${fa_url_names["FA3"]}
					;;
				fa4|FA4)
					work_group=${fa_names["FA4"]}
					work_group_url=${fa_url_names["FA4"]}
					;;
				fa5|FA5)
					work_group=${fa_names["FA5"]}
					work_group_url=${fa_url_names["FA5"]}
					;;
				fa6|FA6)
					work_group=${fa_names["FA6"]}
					work_group_url=${fa_url_names["FA6"]}
					;;
				*)
					work_group="$1"
					work_group_url=""
					;;
			esac
			;;
		*)
			error "Unrecognized argument: $1"
			;;

	esac
	shift
done

missing=()
[[ -z "$repo_name" ]] && missing+=("The repo name is required. ")
[[ -z "$microsite_title" ]] && missing+=("The microsite title is required. ")
[[ -z "$work_group" ]] && missing+=("The work group name is required. ")
[[ ${#missing[@]} > 0 ]] && error "${missing[@]}"

info "Creating a microsite:"
info "  Repo name:   $repo_name"
info "  Title:       $microsite_title"
info "  Work group:  $work_group"

upstream_repo="microsite-template"
targz="$upstream_repo-$$.tar.gz"
untardir="The-AI-Alliance-$upstream_repo"
info "Downloading $targz..."

if [[ -z $NOOP ]]
then 
	curl -L https://api.github.com/repos/The-AI-Alliance/$upstream_repo/tarball > $targz
else
	$NOOP "curl -L https://api.github.com/repos/The-AI-Alliance/$upstream_repo/tarball > $targz"
fi
$NOOP tar xzf $targz
$NOOP rm $targz

for d in ${untardir}*
do
	info "Renaming downloaded directory "$d" to $repo_name:"
	$NOOP mv "$d" $repo_name
done

info "Removing this script file, $script and README.md from your copy of the repo, and moving README-template.md to README.md!"
$NOOP rm "$repo_name/$(basename $script)" "$repo_name/README.md"
$NOOP mv "$repo_name/README-template.md" "$repo_name/README.md"

info "Replacing macro placeholders with values:"
[[ -z "$ymdtimestamp" ]] && ymdtimestamp=$(date +"$ymdformat")
date -j -f "$ymdformat" +"$ymdformat" "$ymdtimestamp" > /dev/null 2>&1
[[ $? -ne 0 ]] && error "Invalid YMD timestamp format for timestamp: $ymdtimestamp" "Required format: $ymdformat"
[[ -z "$timestamp" ]] && timestamp=$(date +"$tsformat")
date -j -f "$tsformat" +"$tsformat" "$timestamp" > /dev/null 2>&1
[[ $? -ne 0 ]] && error "Invalid timestamp format for timestamp: $timestamp" "Required format: $tsformat"


$NOOP cd $repo_name

files=(
	Makefile
	README.md
	publish-website.sh
	update-main.sh
	docs/_config.yml
)
markdown_files=($(find docs -name '*.markdown'))
html_files=($(find docs/_layouts -name '*.html'))

info "Replacing macros with correct values:"
info "  REPO_NAME:            $repo_name"
info "  MICROSITE_TITLE:      $microsite_title"
info "  WORK_GROUP_NAME:      $work_group"
info "  WORK_GROUP_URL_NAME:  $work_group_url"
info "  YMD_TSTAMP:           $ymdtimestamp"
info "  TIMESTAMP:            $timestamp"
info
info "Processing Files:"

for file in "${files[@]}" "${markdown_files[@]}" "${html_files[@]}"
do
	info "  $file"
	if [[ -z $NOOP ]]
	then 
		sed -e "s/REPO_NAME/$repo_name/g" \
		    -e "s/MICROSITE_TITLE/$microsite_title/g" \
		    -e "s/WORK_GROUP_NAME/$work_group/g" \
		    -e "s/WORK_GROUP_URL_NAME/$work_group_url/g" \
		    -e "s/YMD_TSTAMP/$ymdtimestamp/g" \
		    -e "s/TIMESTAMP/$timestamp/g" \
		    -i ".back" "$file"
	else
		$NOOP sed ... -i .back $file
	fi
done

info "Delete the backup '*.back' files that were just made:"
$NOOP find . -name '*.back' -exec rm {} \;


info "Initialize $repo_name as a git repo and add all the files to it:"
$NOOP git init
$NOOP git add * .gitignore docs docs/.prettier* docs/.stylelintrc.json
$NOOP git commit -m "Initial commit for repo $repo_name"

info "Create a 'latest' branch from which the pages will be published:"
$NOOP git checkout -b latest
$NOOP git commit -m 'publication branch: latest' .

info	"Done! The current working directory is $PWD."
next_steps
