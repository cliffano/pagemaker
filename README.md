![Avatar](avatar.jpg)

[![Build Status](https://github.com/cliffano/pagemaker/workflows/CI/badge.svg)](https://github.com/cliffano/pagemaker/actions?query=workflow%3ACI)
[![Security Status](https://snyk.io/test/github/cliffano/pagemaker/badge.svg)](https://snyk.io/test/github/cliffano/pagemaker)

# Pagemaker

Pagemaker is a Makefile for building ProjectSite website .
It provides utility targets for linting and releasing ProjectSite website projects.

Have a look at [PagemakerExample](examples/) as an example project which uses Pagemaker.

## Installation

1. Download `src/Makefile-pagemaker` as the `Makefile` of your project:
    `curl https://raw.githubusercontent.com/cliffano/pagemaker/main/src/Makefile-pagemaker -o Makefile`
2. Create configuration file `pagemaker.yml` with properties described in [Configuration](#configuration) section
3. Run the available `Makefile` targets described in [Usage](#usage) section

## Configuration

| Key | Value |
|-----|-------|
| project_id | pagemaker |
| project_name | Pagemaker |
| project_desc | A sample ProjectSite website built by Pagemaker |
| author_name | Cliffano Subagio |
| author_email | cliffano@gmail.com |
| github_id | cliffano |
| github_repo | pagemaker |

Usage
-----

The following targets are available:

| Target | Description |
|--------|-------------|
| ci | CI target to be executed by CI/CD tool, end to end build of the Python package |
| deps | Retrieve package dependencies using [Poetry](https://python-poetry.org/) |
| lint | Run lint checks against source and test code using [yamllint](https://github.com/adrienverge/yamllint) |
| release-major | Create a major release using [rtk](https://github.com/cliffano/rtk) |
| release-minor | Create a minor release using [rtk](https://github.com/cliffano/rtk) |
| release-patch | Create a patch release using [rtk](https://github.com/cliffano/rtk) |

Colophon
--------

Related Projects:

* [generator-website](https://github.com/cliffano/generator-website) - Website projects generator using Plop
