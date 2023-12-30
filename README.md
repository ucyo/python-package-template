# Template for Python

This a template for developing Python application and libraries in an enclosed
and safe environment. We are using Docker to provide a reproducible environment
which can be used for active development, python packaging for releases and
CI/CD workflows.

## Usage

Copy the example environmental file `.env.example` to `.env` and (if necessary)
add environmental variables.
```bash
$ > cp .env.example .env
```

Start and bash into development container.
```bash
$ > make bash
```

Now your environment is setup. All changes to the codebase are reflected in the
container, since they are mounted.

## Getting Started

### Name your project

The first thing you want to do is give your project a proper name.

1. Rename the `project` in [pyproject.toml](./app/pyproject.toml) and update the `description`.
2. Rename the `app/src/app` to your project name.

    ```bash
    $ > mv app/src/app app/src/<projectname>
    ```

### Add dependencies

Add your dependencies to the project.

1. Enter the development container.

    ```bash
    $ > make bash
    ```

2. Use `rye` to add the dependencies. You can find an introduction to `rye` [here](https://rye-up.com/guide/).

    ```bash
    $ > rye add <dependent package>  # like flask, numpy or pandas
    ```

3. Install the dependencies.

    ```bash
    $ > rye sync
    ```

This will generate (or update) `requirements.lock` and `requirements-dev.lock`.
The next time you build the container your dependencies have been installed.

### Update the README

A fresh start. Just move [the blank README.md](./app/README.md) over here and
start with your project.

```bash
$ > mv src/<projectname>/README.md .
```

## Explore

This template is just the barebone to get a Python Open Source Software (OSS)
project up and running. Don't forget change the license, add a CHANGE.md and
a CODE_OF_CONDUCT.md. But that is up to your :smile:
