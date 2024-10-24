# README for `microsite-template`

This repo is used as a template to create AI Alliance "microsites". 

Rather than copy the repo contents and edit manually, use the `create-microsite.sh` as follows to do most of the hard work for you:

1. Create a working directory and change to it.
2. Run this command to pull down the `zsh` script `create-microsite.sh`:
   ```shell
   curl -L https://raw.githubusercontent.com/The-AI-Alliance/microsite-template/refs/heads/main/create-microsite.sh > create-microsite.sh
   ```
3. When executed, this script will download a `tar.gz` file of the whole repo and create your new website.
4. To see what script arguments you need to provide, run this command (more details below):
   ```shell
   zsh create-microsite.sh --help
   ```
5. Now run it with the required arguments shown, passing the appropriate values for your site. The end of the script prints out some next steps, which are repeated here:

Next Steps after running the script:

1. Go to [https://github.com/The-AI-Alliance](https://github.com/The-AI-Alliance) and create a _public_ repo named with the same name you used. If you don't have permissions, ask Dean Wampler, Adam Pingel, Joe Olson, or Trevor Grant to do this.
3. Follow the instructions given for adding a remote (upstream) location to your local repo. If someone else creates the repo for you, remind them to give you the instructions!
4. Push your local content up to the remote repo! TIP: Make sure both the `main` and `latest` branches are pushed upstream.
5. In GitHub, go to the repo Settings, "Pages" section (left-hand side) to set up GitHub Pages publishing. You want to select `docs` as the folder from which the site is published and `latest` as the branch. (There are more detail instructions in the `README.md` generated for your site, if needed.)

A simpler experience is just to use `main` as the publication branch, so every merge to `main` automatically publishes your updated content. If you really want to do this, ask Dean Wampler for help.

Next, replace the placeholder text and `*.markdown` files with your real content, e.g.,

1. Replace all occurrences of `TODO` with appropriate content.
2. Rename or delete the `second_page.markdown`. Copy it to add more top-level pages, but change the `nav_order` field!
3. Use the `nested` directory content as an example of nesting content or delete it if you don't need it.
4. Make any changes you want to make in the `docs/_config.yml` file. (None are required.)

See also the `README.md` that was created in your new repo for more tips and guidance on development tasks. 

## More about `create-microsite.sh`

Run the command with the `--help` option:

```shell
zsh create-microsite.sh --help
```

It (currently) prints the following:

```text
create-microsite.sh [-h|--help] [-n|--noop] --repo-name|-r name --microsite-title|--site-title|-t title --work-group|-w work_group

Where the options and required arguments are the following:
-h | --help            Print this message and exit
-n | --noop            Just print the commands but don't make changes.

These arguments are required, but they can appear in any order. See the example below:

--repo-name | -r name  The name of gitHub repo. See example below.
--microsite-title | --site-title | -t title
                       The title of microsite.
--work-group | -w work_group
                       The name of work group this site is associated with.

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

The example shows the required arguments: `--repo-name`, `--microsite-title`, and `--work-group`. The values provided are used to replace placeholders in the template files. Other dynamic input includes a timestamp, "now", for when the initial version of the website was created.
