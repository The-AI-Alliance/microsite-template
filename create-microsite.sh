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
-h | --help            Print this message and exit
-n | --noop            Just print the commands but don't make changes.
-s | --next-steps      At the end of running this script to create a new repo,
                       some "next steps" are printed. If you want to see them again,
                       use this flag to print them.
These arguments are required, but they can appear in any order. See the example below:

--repo-name | -r name  The name of gitHub repo. See example below.
--microsite-title | --site-title | -t title
                       The title of microsite. 
--work-group | -w work_group
                       The name of work group this site is associated with.

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

1. Go to https://github.com/The-AI-Alliance and create a _public_ repo named with 
   the same name you used. If you don't have permissions, ask Dean Wampler, 
   Adam Pingel, Joe Olson, or Trevor Grant to do this.
3. Follow the instructions given for adding a remote (upstream) location to your 
   local repo. If someone else creates the repo for you, remind them to give you 
   the instructions!
4. Push your local content up to the remote repo! 
   TIP: Make sure both the "main" and "latest" branches are pushed upstream.
5. In GitHub, go to the repo Settings, "Pages" section (left-hand side) to set up
   GitHub Pages publishing. You want to select "docs" as the folder from which the
   site is published and "latest" as the branch. (There are detailed instructions
   in the "README.md" generated for your site, if needed.)

A simpler experience is just to use "main" as the publication branch, so every 
merge to "main" automatically publishes your updated content. If you really want 
to do this, ask Dean Wampler for help.

Next, replace the placeholder text and "*.markdown" files with your content, e.g.,

1. Replace all occurrences of "TODO" with appropriate content.
2. Rename or delete the "second_page.markdown". Copy it to add more top-level pages,
   but change the "nav_order" field!
3. Use the "nested" directory content as an example of nesting content or delete it
   if you don't need it.
4. Make any changes you want to make in the "docs/_config.yml" file. (None required.)

See also the "README.md" that was created in your new repo for more tips and guidance
on development tasks. 

If you want to see these instructions again, run the following command:

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
#$NOOP rm $targz

for d in ${untardir}*
do
	info "Renaming downloaded directory "$d" to $repo_name:"
	$NOOP mv "$d" $repo_name
done

info "Removing this script file, $script and README.md from your copy of the repo, and moving README-template.md to README.md!"
$NOOP rm "$repo_name/$(basename $script)" "$repo_name/README.md"
$NOOP mv "$repo_name/README-template.md" "$repo_name/README.md"

info "Replacing macro placeholders with values:"
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
$NOOP git commit -m 'Initial commit for repo $repo_name'

info "Create a 'latest' branch from which the pages will be published:"
$NOOP git checkout -b latest
$NOOP git commit -m 'publication branch: latest' .

info	"Done! The current working directory is $PWD."
next_steps
