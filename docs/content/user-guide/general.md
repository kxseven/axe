# General Usage

The AXE tools are intended to function similar to `git` such that;

 - each command is a self-contained tool/script that can be executed atomically if needed
 - valid AXE commands exist as executables in the `$AXE_ROOT/bin/subcommands` directory
 - A parent `axe` tool handles subcommand delegation, including all provided arguments
 - Individual subcommands can exist in a user's PATH that are not part of the default AXE toolset

For more details about the subcommand approach can be found [here](https://www.kernel.org/pub/software/scm/git/docs/howto/new-command.html)

## The `axe` command

 - Invoking an AXE command without any args will display it's default 'help' text

    ```
    $ axe
    usage: axe [--version] [--help] <command> [<args>]

    The most commonly used commands are:
      auth-setup        Create or update IAM Roles and Groups with policies
      auth-report       List the currently provisioned credentials
      instance-list     Lists instances in the currently accessable VPC(s)
      scp               Wrapper for SCP configured to use loaded AWS idemtity
      ssh               Wrapper for SSH configured to use loaded AWS idemtity

    'axe -h' lists available subcommands
    ```

## Common arguments and defaults

!!! warning "Requires a valid identity loaded"
    In almost all cases the AXE subcommand will only function correctly once a valid identity has been loaded

 - In most cases AXE subcommands will accept the following arguments and switches

    ```
    -y, --yes             Actually do anything. Otherwise runs in dry-run mode
    -h, --help            show this help message and exit
    --debug               More verbose (usually debug) logging and output
    ```

 - All of the AXE subcommands will display their help text if invoked with the `-h` or `--help`
 - Many of the AXE subcommands will display verbose outbut if invoked with `--debug`
 - All of the AXE subcommands will output logging to `$AXE_ROOT/log/<subcommand>.log`
 - Where an AXE subcommand is creating resources it will require a `-y` argument in order to actually make any changes. This is intentional to prevent applying changes


## Sub Commands

Each of the AXE commands exists as a stand-along scriptlet in `$AXE_ROOT/bin/subcommands/`. All of the currently available AXE commands can be displayed using `axe -h`

```
user@host$> axe -h
usage: axe [--version] [--help] <command> [<args>]

available commands in '$AXE_ROOT/bin/subcommands'

auth-list-keys                  get-vols-by-id
auth-report                     grafana-build-dashboards
auth-setup                      image-list
auth-token-create               instance-create
cloud-template-create           instance-list
docs                            scp
dump-account                    ssh
env-list
```


## Utility Commands

There are additional utility scriptlets in `$AXE_ROOT/bin/tools/` which are intended to be helper scripts for processing AWS data at the command line and from which several of the AXE commands themselves rely on.

| Tool/Command    | Description                                                                                        |
|:---------------- |:--------------------------------------------------------------------------------------------------- |
| kfl             | Runs the provided command with args, keeping the first line of the original output. (Useful when the first line contains headers: CSV, etc)                                  |
| axegrep         | Based on `kfl` but keeps the first 2 lines which are generally the AXE output header                                                                                         |
| axemap          | Attempts to match text tags to resource IDs for a specific resource type; SG names -to- SG ids                                                                               |
| cache           | Caches the output of the command for up to X mins such that subsequent runs of the same command use the cached output. Useful for caching the output of verbose AWS commands |
| json2properties | Converts JSON to Java Properties syntax                                                                                                                                      |
| json2table      | Attempts to tabularize JSON input into tabular data based on the first keys of a dict or rows in an array                                                                    |

