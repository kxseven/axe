# Developer Notes

## Contributing

Published where people more talented than I can readily suggest improvements. If you see an error or something that could be better, please submit an issue.

### General Guidelines

 - **Master branch is for merging incoming changes**. Do not make any changes direcly on the master branch.

 - **Create topic branches**. Don't ask for a pull from your master branch.

 - **One pull request per feature**. If you want to do more than one thing, send multiple pull requests.

 - **Send coherent history**. Make sure each individual commit in your pull request is meaningful. If you had to make multiple intermediate commits while developing, please squash them before sending them.

 - Fork the project, clone your fork, and configure the remotes:

        # clone your fork of the repo into the current directory in terminal
        git clone git@bitbucket.org:<your username>/axe.git
        # navigate to the newly cloned directory
        cd axe
        # assign the original repo to a remote called "upstream"
        git remote add upstream git@bitbucket.org:kxseven/axe.git

 - If you cloned a while ago, get the latest changes from upstream:

        # fetch upstream changes
        git fetch upstream
        # make sure you are on your 'master' branch
        git checkout master
        # merge upstream changes
        git merge upstream/master

 - Create a new topic branch to contain your feature, change, or fix:

        git checkout -b <topic-branch-name>

 - Commit your changes in logical chunks. or your pull request is unlikely be merged into the main project. Use git's interactive re-base feature to tidy up your commits before making them public.

 - Make sure you run your code through PyLint for basic error and warnings.

 - Push your topic branch up to your fork:

        git push origin <topic-branch-name>

 - Open a Pull Request with a clear title and description.
