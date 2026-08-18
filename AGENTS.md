# REPO_NAME_MACRO Repo Guide

This repository is the technical home for the REPO_NAME_MACRO project. Use this file as the fast path for orientation, navigation, and local conventions.

## Repository Map

- `README.md` is the top-level overview for contributors and developers.
- `CONTRIBUTING.md` describes our requirements and guidelines for those people who wish to contribute to this project.
- `SECURITY.md` describes the project security policy and how to report vulnerabilities and related issues.
- `Makefile` is the main task entry point for setup, tests, formatting, linting, type checking, and local docs serving.
- `.*.mk` (e.g., `.common.mk`, `.console-colors.mk`, `.website.mk`, etc.) are support `make` files read by `Makefile`.
- `pyproject.toml` describes the Python dependencies and provides some configuration settings for them.
- `LICENSES/` contains our preferred licenses, which are described in `CONTRIBUTING.md`.
- `src/` holds the source code for any Python packages.
- `src/tests/` mirrors the other `src/*` directories and holds the test suite.
- `docs/` is the GitHub Pages site. It is the user-facing technical website.
- `GITHUB_PAGES.md` describes the website that is published using GitHub Pages.
- `Gemfile` and `Gemfile.lock` are used by Ruby for serving the GitHub Pages website locally.
- `*.local/` (e.g., `dw.local/`) is local workspace material and is intentionally excluded from repo-wide navigation guidance unless a task explicitly says otherwise.

## Where To Look First

- For repo setup and contributor workflow: `README.md` and `CONTRIBUTING.md`
- For local build and verification commands: `Makefile` and `.*.mk`
- For the website structure and pages: `GITHUB_PAGES.md`, and the `docs/**/*.markdown` files
- For the current Python implementation surface (if present): `src/`
- For the current tests (if present): `src/tests/`

## The Website `docs` Map

The `docs/` directory contains the website content. The major pages, subsections, and other content are as follows (but more may be added later that aren't reflected here):

- `docs/about.markdown` discusses the project and the AI Alliance.
- `docs/contributing.markdown` discusses how to contribute.
- `docs/index.markdown` is the website home page.
- `docs/**/*.markdown` subsections of the site that contain one or more `*.markdown` pages. The index page for each subsystem is usually named `index.markdown`.

The website may link to the [AI Alliance glossary](https://the-ai-alliance.github.io/glossary/). If you have suggestions for new glossary terms to add or improvements for existing terms, describe them in your discussion of your work.

## Python Package Layout

The Python code is found under `src/` and will be organized into packages. Corresponding tests are found in the same package structured under `src/tests/`.

## Working Conventions

- Use Python 3.13 and `uv` for environment management.
- Prefer `make` targets for common tasks:
  - `make one-time-setup`
  - `make tests` or `make unit-tests`
  - `make format`
  - `make lint`
  - `make type-check`
  - `make before-pr`
  - `make view-local`
- The default repo test command is `make tests` / `make unit-tests`, which runs discovery from `src`.
- `pytest` is also configured in `pyproject.toml` and is useful for targeted test runs.
- Keep Python formatting consistent with `black` and the repo line length setting in `pyproject.toml` for `tool.black` formatting.
- Keep lint/type annotations compatible with `ruff`, `pylint`, and `ty`.
- Preserve the website style in `docs/`: Markdown pages, Jekyll front matter, and Just the Docs structure.
- When editing documentation, keep the audience technical and contributor-focused rather than promotional.
- When creating or editing Markdown under `docs/`, do not hard-wrap prose paragraphs; use soft wrap and break only for Markdown structure.
- If diagrams would be useful in new documentation, use inline Mermaid diagrams.

## Plain English (PRs and issues)

Write so a busy reviewer or contributor can understand the point without decoding jargon. Technical precision belongs *after* a clear opening, not instead of one.

- Prefer short sentences and common words when they still say the same thing (“who controls the data” over “control-plane sovereignty boundary”).
- Define project terms on first use, or link to the [AI Alliance glossary](https://the-ai-alliance.github.io/glossary/) definition — do not assume every reader has the full corpus memorized.
- Avoid stacking abstractions, acronyms, and file paths in the first screen of text.
- Comments on issues and PRs should answer in plain language first; optional detail or links can follow.

This applies especially to **issue bodies**, **issue comments**, **PR titles**, and **PR description openings**.

## Pull Request Descriptions

Write PR titles and bodies for human skimming first. Detail is welcome later; the opening must stand alone in plain English.

**Title.** Outcome-oriented and specific enough to understand without opening the PR (e.g. `Add new feature that allows the user to choose an LLM`, not a file-list or implementation diary).

**Opening (fixed order, plain English).** Put this at the top of the description — before file inventories, commit archaeology, or deep rationale:

1. **Why** — the problem or gap this PR addresses.
2. **What** — the proposed approach and what reviewers, users, or the project get when it lands (the result, not the mechanism).

A reviewer who reads only the title and these two beats should understand the forest. If those two beats need a glossary to parse, rewrite them.

**How (details after).** Implementation notes, files touched, edge cases, test evidence, and checklist items come next. Density is fine here.

- When a structural overview helps, **precede the detailed how** with one high-level, inline Mermaid diagram. Use it for flows, phase shifts, or decision structure — not for typo fixes or pure prose polish.
- At most one diagram in that leading-how position; further diagrams belong deeper in the details if needed.
- Prefer project language over repo archaeology in the opening (“propose a gate-then-score selection method” rather than “updated `classDef` in README”).

Keep using the repo PR templates under `.github/PULL_REQUEST_TEMPLATE/` for checklists and contribution process; lead their description sections with Why → What as above.

## Issue titles and bodies

Same skimming bar as PRs: a reader should know the ask from the title plus the first short paragraph.

**Title.** Name the outcome or question, not the internal ticket shape (e.g. `Pick base model for the #70 two-node experiment`, not `Task/Feature/Issue follow-up`).

**Body opening.** In plain English, state:

1. **Why this exists** — the gap, risk, or decision needed.
2. **What success looks like** — a concrete done condition, decision, or artifact.

Then add background, acceptance criteria, links to issues and documentation. Template fields under `.github/ISSUE_TEMPLATE/` still apply; fill them in readable prose, not telegram-style jargon.

**Comments.** Prefer a clear recommendation or question in the first sentences. Long analysis is welcome after that. When comparing options, say what each option *does for the project* before naming tools or stacks.

## Practical Notes

- Match tests to the package layout instead of creating a separate test structure.
- Avoid broad refactors unless they are required to keep boundaries clear.
- Prefer small, focused changes that stay inside the subsystem you are touching.
- Treat `docs/` content as the first stop for architecture, requirements, and design context.
- For repo-wide navigation, ignore `*.local/` directories (e.g., `dw.local/`) unless the task specifically asks for it.
