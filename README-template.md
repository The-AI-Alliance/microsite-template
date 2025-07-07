# How to Use `microsite-template`

This repo is used as a template to create AI Alliance &ldquo;microsites&rdquo;. It is setup as a GitHub _template repo_, which you can use to create a new repo. Even if you aren't creating a microsite, you can use this procedure to create a new AI Alliance repo for other purposes. 

## Creating Your Repo

These are the main steps, with details below:

1. Create your repo from the [this template repo](https://github.com/The-AI-Alliance/microsite-template).
1. Convert placeholder _variables_ to the correct values, using the [`finish-microsite.sh`](https://github.com/The-AI-Alliance/microsite-template/blob/main/finish-microsite.sh) script.
1. Modify the "header buttons" in `docs/includes/header_buttons_custom.html`to be what you want to appear at the top of each page. See the [OTDI](https://the-ai-alliance.github.io/open-trusted-data-initiative/) site for an example customization. Or if you don't want any buttons, delete the contents of that file (but don't delete the file...).
1. Add your initial custom content for the pages in the `docs` directory.
1. Add your initial custom content to the `README.md` in the repo.
1. **If** you plan to publish the website from the `latest` branch, merge changes to that branch from `main`, commit the changes, and push both branches upstream.
1. Edit the repo's _Settings_. 
  1. On the repo's home page in GitHub, click the _Settings_ "gear" on the upper right-hand side. 
  1. Scroll down to _Features_ and click _Discussions_ to enable them (unless you don't want them; in this case, remove the URL on the `docs/contributing.markdown` page!).
  1. On the left-hand side, click the link for _Pages_. Under _Branch_, select the `main` or `latest` branch depending on which one you want to use, then select the `/docs` directory.
1. Add the website to the Alliance GitHub organization [landing page](https://github.com/The-AI-Alliance/) and the Alliance GitHub [website](https://the-ai-alliance.github.io/#the-ai-alliance-projects).
1. Delete this file, `README-template.md`, and `finish-microsite.sh` from both branches!

> [!NOTE] 
> We are planning to automate as many of the manual steps as we can.

Let's look at these steps in more detail.

### 1. Create your repo from the `microsite-template`.

Pick a name for your new repo and follow [these GitHub instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) to create a new repo from the [`microsite-template`](https://github.com/The-AI-Alliance/microsite-template) repo.

### 2. Convert the placeholder _variables_.

After step 1., your repo will have placeholder values for the project name, etc. Next, change to the repo root directory and run the script [`finish-microsite.sh`](https://github.com/The-AI-Alliance/microsite-template/blob/main/finish-microsite.sh) to replace the placeholder _variables_ with appropriate strings for your project.

> [!WARNING]
> The `finish-microsite.sh` script uses `zsh`. If you don't have `zsh` available, then use `bash` version 5 or later, e.g., `bash finish-microsite.sh ...`.

At the time of this writing, here are the required arguments shown with example values for a repo named `ai-for-evil-project` under the auspices of the _Trust and Safety_ focus area work group:

```shell
./finish-microsite.sh \
  --microsite-title "AI for Evil Project" \
  --work-group fa2
```

Referring to a focus area by number or `FA#`, (e.g., `2`, `fa2`, `FA2`, `Fa2`, or `fA2`) is expanded as follows:

| Number | Abbreviation   | Full name |
| :----- | :------------- | :-------- |
|        | (case ignored) | |
| `1`    | `FA1`          | Skills and Education |
| `2`    | `FA2`          | Trust and Safety |
| `3`    | `FA3`          | Applications and Tools |
| `4`    | `FA4`          | Hardware Enablement |
| `5`    | `FA5`          | Foundation Models and Datasets |
| `6`    | `FA6`          | Advocacy |

> [!NOTE]
> 1. Run the script with `zsh`, **_not_** `bash`.
> 2. To see the current list of required arguments and optional argument, run the script with the `--help` flag.
> 3. By default, the website will be published from the `main` branch. If you prefer to use a different branch, we have used `latest` as a convention for most of the microsites. In this case, add the flag `--use-latest`. If you prefer to use a different branch, use `--publish-branch BRANCH`.

> [!WARNING]
> After running the script, your changes are only in your local repo, not pushed upstream. We'll fix that in step 5 below.

### 3. Edit the website buttons.

There are purple "header buttons" that appear on all pages in the website. You can see in existing websites, e.g., [OTDI](https://the-ai-alliance.github.io/open-trusted-data-initiative/). They are defined in the file `docs/includes/header_buttons_custom.html`. Edit this file to define buttons that work for you. ([OTDI](https://the-ai-alliance.github.io/open-trusted-data-initiative/ is an example of customization.) Or if you don't want any buttons, delete the contents of that file, but don't delete the file.

### 4. Add your initial custom content for the pages in the `docs` directory.

> [!NOTE]
> If you are creating a repo for code, not a microsite, delete the `docs` directory and skip to the next step.

There are other placeholder texts in the `docs/**/*.markdown`, README, and other files that you should replace with your real content as soon as possible, e.g.,

1. Find and replace all occurrences of `TODO` with appropriate content.
1. Rename or delete the `second_page.markdown`. Copy it to add more top-level pages, but change the `nav_order` field to control the order of the pages shown in the left-hand side navigation view. 

> [!TIP]
> Start with `10`, `20`, etc. for the `nav_order` of top-level pages, giving yourself room to insert new pages in between existing pages. For nested pages, e.g., under `20`, use `210`, `220`, etc.
3. See the `nested` directory content as an example of how to do nesting, or delete it if you don't need it. Note the metadata fields at the top, such as the `parent` and `has_children` fields.
4. Make any changes you want to make in the `docs/_config.yml` file. (None are mandatory.)

For more tips and guidance on development tasks, see also the links for more information in the `README.md` in your new repo. Add a project-specific description at the beginning of that file.

### 5. Add your initial custom content to the `README.md` in the repo.

The `README.md` contains useful _boilerplate_ for contributors, but the preamble at the beginning should be customized with useful "welcome" information about the project.

### 6. Merge changes to the `latest` (or another) branch and push both branches upstream.

By default, the website is published from the `main` branch, for convenience. However, if you choose to use the `latest` branch or another branch (see above), follow these instructions.

> [!NOTE]
> If you are creating a repo for code, not a microsite, you can delete the `latest` branch:
>
> ```shell
> git br -D latest
> ``` 
>
> Also delete the upstream branch in the GitHub page for your repo. Then skip to the next step.

As discussed in [`GITHUB_PAGES.md`](https://github.com/The-AI-Alliance/the-ai-alliance.github.io/blob/main/GITHUB_PAGES.md), by default we publish the "microsite" from the `main` branch, but previously our convention was to use the `latest` branch for publishing and restrict the `main` to be the pre-publishing "work" branch. Assuming you made custom edits above on the `main` branch, merge them to `latest`. If you are using a different publishing branch, change `latest` accordingly:

```shell
git checkout latest
git merge main
```

Now push all updates upstream:

```shell
git push --all
```

Adding `--all` pushes the commmits on all the local branches upstream.

### 7. Edit the repo's _Settings_. 

On the repo's home page in GitHub, click the _Settings_ "gear" on the upper right-hand side. 

#### 7a. Enable discussions.

Scroll down to _Features_ and click _Discussions_ to enable them. However, if you don't want discussions, remove the URL on the `docs/contributing.markdown` page. (Don't forget to merge that edit to both branches.)

Click the _Set up discussions_ button and edit the first discussion topic to taste, then post it.

#### 7b. Publish your website.

> [!NOTE]
> If you are creating a repo for code, not a microsite, ignore this section.

On the left-hand side of the _Settings_, click the link for _Pages_. Under _Branch_, select your publication branch, either `main`, `latest`, or a custom branch you specified above. Then select the `/docs` directory and finally, click _Save_.

Your website should be published after a few minutes to https://the-ai-alliance.github.io/REPO_NAME/.

### 8. Add your website to the Alliance GitHub organization page and the Alliance website.

> [!NOTE]
> This step applies for code repos, not just documentation repos.

Add the website to the Alliance GitHub organization [landing page](https://github.com/The-AI-Alliance/) and the Alliance GitHub Pages [website](https://the-ai-alliance.github.io/#the-ai-alliance-projects).

When you are ready for broader exposure for your site, there are a few places where we have an index to all the &ldquo;microsites&rdquo;. Add your site in the table shown in each of the following locations. Note how the rows are grouped by focus area. Your new entry will go in the table with the other projects/initiatives for your focus area.

* https://github.com/The-AI-Alliance/.github/blob/main/profile/README.md
* https://github.com/The-AI-Alliance/the-ai-alliance.github.io/blob/main/docs/index.markdown

> [!NOTE]
> You only need to edit the first file, the `README.md`. Afterwards, notify Dean Wampler ([email](mailto:dwampler@thealliance.ai), [Slack](https://ai-alliance-workspace.slack.com/team/U068AL1C30E)) of your change. Dean will run a tool that copies the change to the other location.

You can just edit the page directly in GitHub and submit a PR.

Finally, talk to your focus area leaders about updating the main [AI Alliance website](https://thealliance.ai) with information about your project site.

### 9. Delete this file, `README-template.md`, and `finish-microsite.sh` from both branches!

These two files are no longer needed, so you can remove them from your repo:

```shell
git rm README-template.md finish-microsite.sh
```

If you are building a microsite and if you are using a separate publishing branch, like `latest`, then merge this change to it, too:

```shell
git checkout latest  # or another branch...
git merge main
```

Finally, push upstream:

```shell
git push --all
```
