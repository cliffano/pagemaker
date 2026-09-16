# AGENTS.md

This repository contains a ProjectSite website project following a unified
standard for tooling, build automation, and coding conventions. All projects
share the same conventions to keep sites consistent and maintainable.

The key components of the standard include:

- Build automation (PageMaker)
- Content generation from project metadata (Jazz templating)
- Documentation linting (JSON linting, YAML linting, markdownlint/mdl, link checking)
- Static documentation publishing

This document outlines the common conventions that apply across the ProjectSite
website projects.

## Runtime & Dependencies

- **Node.js Version**: 26
- **Dependency Manager**: npm
- **Content Templating**: Jazz (jazz-cli)
- **Configuration Tooling**: yq

### Adding Dependencies

```bash
npm install package_name          # Add runtime dependency
npm install --save-dev pkg_name   # Add development dependency
make deps                         # Install all dependencies
```

## Project Structure

```text
project/
├── data/                    # Project metadata (project-info.json)
├── docs/                    # Generated site output (index.md, images/)
├── templates/               # Jazz content templates (index.md.jazz)
├── .github/                 # GitHub workflows
├── Makefile                 # Build automation (PageMaker)
├── package.json             # npm package definition
└── README.md                # Project README
```

## Build Automation (PageMaker)

This project uses **PageMaker** as its standard build automation tool for
ProjectSite website projects.

### Common Commands

```bash
make ci                 # Run clean + lint + build
make all                # Alias for ci
make clean              # Remove staged/generated files
make deps               # Install dependencies (npm + markdownlint via apt)
make deps-upgrade       # Upgrade dependencies via pkjutil
make lint               # Validate JSON data, workflow YAML, and Markdown
make build              # Merge data/project-info.json into templates/index.md.jazz -> docs/index.md
make test               # Check links in docs/index.md
```

### Update Targets

```bash
make update-to-latest   # Update Makefile to latest PageMaker release
make update-to-main     # Update Makefile to PageMaker main branch
make update-to-version  # Update Makefile to a specific PageMaker version
make update-dotfiles    # Refresh project dotfiles from generator-website
make update-partials    # Refresh README partial snippets from generator-website
```

## Development Environment

This project is designed to be developed in a consistent environment via Docker
image `cliffano/studio`.

You can run the container using: `docker run --rm --workdir /opt/workspace -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/opt/workspace -i -t cliffano/studio` and then run the build commands inside the container.

## Code Style and Linting

- JSON, YAML, and Markdown files are validated via `make lint`
- Generated `docs/index.md` output should stay traceable to its `data/` and `templates/` sources

### ProjectSite Code Guidelines

Applies to: `.github/workflows/**/*.yml`, `.github/workflows/**/*.yaml`, `data/**/*.json`, `templates/**/*.jazz`, `docs/**/*.md`, `README.md`, `CHANGELOG.md`

#### Style & Formatting

##### Workflow and Build Config

All workflow and build configuration changes should stay explicit, readable, and
reproducible.

Guidelines:

- Use two-space indentation in YAML files
- Keep workflow/job/step names descriptive
- Avoid compact one-liners that hide intent in CI definitions
- Keep shell snippets readable and fail fast

##### Data Files

Data files should remain valid JSON:

```bash
make lint
```

Guidelines:

- Keep JSON keys stable and descriptive
- Prefer explicit objects over ambiguous arrays when feasible
- Keep data formatting consistent to reduce noisy diffs

##### Content Templates

Guidelines:

- Keep `templates/index.md.jazz` focused on presentation, not heavy logic
- Keep `data/project-info.json` as the source-of-truth for generated content
- Treat `docs/index.md` as generated output; regenerate with `make build` rather than editing it by hand

#### Site Structure Conventions

- Keep project metadata in `data/project-info.json`
- Keep content templates in `templates/`
- Keep generated output in `docs/`

#### Validation

- Treat lint failures as build failures
- Run `make build` after any `data/` or `templates/` change and verify the `docs/index.md` output
- Run `make test` to catch broken links in generated documentation

## Testing

- This project emphasizes deterministic lint/build/link checks rather than unit test suites
- Run validation with `make ci`

### Testing Guidelines

Applies to: `.github/workflows/**/*.yml`, `.github/workflows/**/*.yaml`

#### Validation Strategy

This project currently relies on deterministic validation via lint/build/link
checks rather than dedicated unit test suites.

Primary validation commands:

```bash
make ci
make test
```

#### What to Validate

- JSON data integrity (`make lint`)
- Site build success (`make build`)
- Link checks in generated documentation (`make test`)
- Workflow execution consistency for CI and publish flows

#### Workflow Test Practices

- Keep CI steps deterministic and idempotent
- Avoid network-dependent checks unless required by link-check behavior
- Fail fast on missing configuration values

#### Regression Prevention

When changing content generation, data model, or template behavior:

1. Run `make lint`
2. Run `make build` and verify the `docs/index.md` output
3. Run `make test`
4. Verify generated documentation changes are intentional
