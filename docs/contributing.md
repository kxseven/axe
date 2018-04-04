# Contributing to AXE

AXE is published where people more talented than I can readily suggest improvements. If you see an error or something that could be better, please submit an issue.

## General Guidelines

 - **Master branch is for merging incoming changes**. Do not make any changes direcly on the master branch.

 - **Create topic branches**. Don't ask for a pull from your master branch.

 - **One pull request per feature**. If you want to do more than one thing, send multiple pull requests.

 - **Send coherent history**. Make sure each individual commit in your pull request is meaningful. If you had to make multiple intermediate commits while developing, please squash them before sending them.

 - Fork the project, clone your fork, and configure the remotes:

    ``` shell
    # clone your fork of the repo into the current directory in terminal
    git clone https://github.com/<your-username>/axe.git
    # navigate to the newly cloned directory
    cd axe
    # assign the original repo to a remote called "upstream"
    git remote add upstream https://github.com/kxseven/axe.gi
    ```

 - If you cloned a while ago, get the latest changes from upstream:

    ``` shell
    # fetch upstream changes
    git fetch upstream
    # make sure you are on your 'master' branch
    git checkout master
    # merge upstream changes
    git merge upstream/master
    ```

 - Create a new topic branch to contain your feature, change, or fix:

    ``` shell
    git checkout -b <topic-branch-name>
    ```

 - Commit your changes in logical chunks. or your pull request is unlikely be merged into the main project. Use git's interactive re-base feature to tidy up your commits before making them public.

 - Make sure you run your code through PyLint for basic error and warnings.

 - Push your topic branch up to your fork:

    ``` shell
    git push origin <topic-branch-name>
    ```

 - Open a Pull Request with a clear title and description.


## Coding conventions

  * We indent using four spaces
  * Remove any major problems reported by PEP8 (I like [flake8]) for Python and [shellcheck] for BASH
  * We put spaces after list items and method parameters (`[1, 2, 3]`, not `[1,2,3]`), around operators (`x += 1`, not `x+=1`), and around hash arrows.
  * This is open source software. Consider the people who will read your code, and make it look nice for them. It's sort of like driving a car: Perhaps you love doing donuts when you're alone, but with passengers the goal is to make the ride as smooth as possible.

[shellcheck]: https://github.com/koalaman/shellcheck
[flake8]: http://flake8.pycqa.org/en/latest/

## Developer Packages Required

In order to do development on AXE you will need to install the list of additional Python packages from `requirements.development`

``` shell
$ goaxe
$ pip install -r requirements/requirements.development
$ pip install -r requirements/requirements.docs
```

You may find it more convenient to create a separate Python VirtualEnv for development to keep packages and versions distinct

