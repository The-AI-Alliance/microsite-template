# README for `microsite-template`

This repo is used as a template to create AI Alliance "microsites". 

Rather than copy the repo contents and edit manually, use the `create-microsite.sh` as follows to do most of the hard work for you:

1. Create a working directory and change to it.
2. Run this command to pull down the `zsh` script `create-microsite.sh`:
   ```shell
   curl -L https://raw.githubusercontent.com/The-AI-Alliance/microsite-template/refs/heads/main/create-microsite.sh > create-microsite.sh
   ```
3. When executed, this script will download a `tar.gz` file of the whole repo and create your new website.
4. To see what script arguments you need to provide, run this command:
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
