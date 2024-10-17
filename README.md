# README for `microsite-template`

This repo is used as a template to create AI Alliance "microsites". 

Rather than copy the repo contents and edit manually, use the `create-microsite.sh` as follows to do most of the hard work for you:

1. Create a working directory and change to it.
2. Run this command to pull down the `zsh` script `create-microsite.sh`:
   ```shell
   curl -L https://raw.githubusercontent.com/The-AI-Alliance/microsite-template/refs/heads/main/create-microsite.sh > create-microsite.sh
   ```
3. When executed, this script will download a `tar.gz` file of the whole repo and creates your new website.
4. To see what options you need to provide, run this command:
   ```shell
   zsh create-microsite.sh --help
   ```
5. Now run it with the required arguments shown, passing the appropriate values for your site.


