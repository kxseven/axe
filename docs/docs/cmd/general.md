# General Usage

The AXE tools are intended to function similar to `git` such that;

 - each command is a self-contained tool/script that can be executed atomically if needed
 - valid AXE commands exist as executables in the `$AXE_ROOT/bin/subcommands` directory
 - A parent `axe` tool handles subcommand delegation, including all provided arguments
 - Individual subcommands can exist in a user's PATH that are not part of the default AXE toolset

For more details about the subcommand approach can be found [here](https://www.kernel.org/pub/software/scm/git/docs/howto/new-command.html)

## The `axe` command

 - Invoking an AXE command without any args will display it's default 'help' text

        $ axe
        usage: axe [--version] [--help] <command> [<args>]

        The most commonly used commands are:
          docs              View the documentation in your browser
          auth-setup        Create or update IAM Roles and Groups with policies
          auth-report       List the currently provisioned credentials
          instance-create   Provision EC2 instances with tagging into existing VPC(s)
          instance-list     Lists instances in the currently accessable VPC(s)
          scp               Wrapper for SCP configured to use loaded AWS idemtity
          ssh               Wrapper for SSH configured to use loaded AWS idemtity

        'axe -h' lists available subcommands

 - Invoking the `axe` command with the `-h` argument will also list all of the available AXE subcommands found

        $ axe -h
        usage: axe [--version] [--help] <command> [<args>]

        available commands in '$AXE_ROOT/bin/subcommands'

        auth-report             docs                    instance-list
        auth-setup              env-list                scp
        auth-token-create       image-list              ssh
        cloud-template-create   instance-create


## Common arguments and defaults

 - In almost all cases the AXE **subcommand will only function correctly once a valid identity has been loaded**
 - In most cases AXE subcommands will accept the following arguments and switches

        -c <cb-root>, --cb-root=<cb-root>
                              The $CLOUDBUILDER_ROOT defaults to ~/.cloudbuilder but
                              can be overridden if required. [default: ~/.cloudbuilder]
        -e <env-dir>, --envname=<env-dir>
                              Environment directory for inputs and outputs relative
                              to $CLOUDBUILDER_ROOT including authentication_config.yaml
        -y, --yes             Actually do anything. Otherwise runs in dry-run mode
        -h, --help            show this help message and exit
        --debug               More verbose (usually debug) logging and output

 - the `cb-root` and `env-dir` params are provided so that multiple customers (cb-root) with multiple environments (env-dir) can be used independantly
 - All of the AXE subcommands will display their help text if invoked with the `-h` or `--help`
 - Many of the AXE subcommands will display verbose outbut if invoked with `--debug`
 - All of the AXE subcommands will output logging to `$AXE_ROOT/log/<subcommand>.log`
 - Where an AXE subcommand is creating resources it will require a `-y` argument in order to actually make any changes. This is intentional to prevent applying changes

