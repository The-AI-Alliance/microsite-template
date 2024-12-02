# README for `microsite-template`

This repo is used as a template to create AI Alliance &ldquo;microsites&rdquo;. 

## Creating Your Website

Follow these instructions to create your new website using this template repo.

### 1. Run a Script to Create the Repo &ldquo;Skeleton&rdquo; for Your Site

Rather than copy this repo's contents and edit everything manually, use the [`create-microsite.sh`](https://github.com/The-AI-Alliance/microsite-template/blob/main/create-microsite.sh) script as follows to do a lot of the hard work for you:

1. Create a working directory and change to it.
1. Run this command to pull down the `zsh` script [`create-microsite.sh`](https://github.com/The-AI-Alliance/microsite-template/blob/main/create-microsite.sh) into the current working directory:
   ```shell
   curl -L https://raw.githubusercontent.com/The-AI-Alliance/microsite-template/refs/heads/main/create-microsite.sh > create-microsite.sh
   ```
> [!NOTE]
> When executed, this script will download a `tar.gz` file of the whole repo and create your new website.
3. To see what script arguments you need to provide, run this command (more details below):
   ```shell
   zsh create-microsite.sh --help
   ```
4. Now run it with the required arguments shown, passing the appropriate values for your site. When finished, the script will tell you to continue here, for the rest of the steps.

### 2. Create an Upstream Repo

There are more detailed instructions for the following steps, if needed. See the links in the `README.md` generated for your site.

1. Go to [https://github.com/The-AI-Alliance](https://github.com/The-AI-Alliance) and create a _public_ repo with the same name you used. If you don't have permission to do this, ask Dean Wampler, Adam Pingel, Joe Olson, or Trevor Grant to do this for you.
1. Follow the instructions given for adding a remote (upstream) location to your local repo. If someone else creates the repo for you, remind them to give you the instructions!
1. Push your local content up to the remote repo! 
> [!WARNING]
> Make sure both the `main` and `latest` branches are pushed upstream.[&sup1;](#footnote-1)
4. Back in the GitHub repo, go to the repo _Settings_ tab (at the top), then the _Pages_ section (link on the left-hand side) to set up GitHub Pages publishing. You want to select `docs` as the folder from which the site is published and `latest` as the branch (or `main`[&sup1;](#footnote-1)). 

<a name="footnote-1"></a>
&sup1; A simpler experience is just using `main` as the publication branch, so every merge to `main` automatically publishes your updated content. This is best used for temporary sites (e.g., for conference workshops) with infrequent updates. If you really want to do this, ask [Dean Wampler](mailto@dwampler@thealliance.ai) for help.

### 3. Replace the Placeholder Markdown Text

Next, replace the placeholder text and `*.markdown` files with your real content, e.g.,

1. Replace all occurrences of `TODO` with appropriate content.
1. Rename or delete the `second_page.markdown`. Copy it to add more top-level pages, but change the `nav_order` field to control the order of the pages shown in the left-hand side navigation view. 
> [!TIP]
> Start with `10`, `20`, etc. for these pages, giving yourself room to insert new pages in between existing pages.
3. Use the `nested` directory content as an example of nesting content or delete it if you don't need it. Note the metadata fields at the top, such as the `parent` and `has_children` fields.
4. Make any changes you want to make in the `docs/_config.yml` file. (None are mandatory.)

For more tips and guidance on development tasks, see also the links for more information in the `README.md` that was created in your new repo. Add a project-specific description at the beginning of that file.

### 4. Add Your website to the Alliance GitHub Pages and the Alliance Website

When you are ready for broader exposure for your site, there are a few places where we have an index to all the &ldquo;microsites&rdquo;. Add your site in the table shown in each of the following locations. Note how the rows are grouped by focus area. Put your new row with the others in your focus area.

* https://github.com/The-AI-Alliance/.github/blob/main/profile/README.md
* https://github.com/The-AI-Alliance/the-ai-alliance.github.io/blob/main/docs/index.markdown

You can just edit the page directly in GitHub and submit a PR. Note that for the second link, the `index.markdown` page for the `the-ai-alliance.github.io` site, we add `{:target="..."}` annotations to each link. Just use a unique name for your links.

Finally, talk to your focus area leaders about updating the [AI Alliance website](https://thealliance.ai) with information about your project site.

## More about `create-microsite.sh`

Here is more information about this script, including the required arguments.

Run the command with the `--help` option:

```shell
zsh create-microsite.sh --help
```

It (currently) prints the following:

```text
create-microsite.sh [-h|--help] [-n|--noop] [--ns|--next-steps] \ 
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

create-microsite.sh --repo-name ai-for-evil-project --microsite-title "AI for Evil Project" --work-group fa2

Note that just specifying "fa1" or "FA1", etc. for any of the focus areas will result in the
following names being used:

FA1: FA1: Skills and Education
FA2: FA2: Trust and Safety
FA3: FA3: Applications and Tools
FA4: FA4: Hardware Enablement
FA5: FA5: Foundation Models and Datasets
FA6: FA6: Advocacy

NOTE: The title and work group strings need to be quoted if they contain spaces!
```

The example shows the required arguments: `--repo-name`, `--microsite-title`, and `--work-group`. The values provided are used to replace placeholders in the template files. Other dynamic input includes a timestamp ("now"), for when the initial version of the website was created, and an initial version string `V0.1.0`.
