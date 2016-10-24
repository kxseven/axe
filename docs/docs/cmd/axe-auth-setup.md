# axe-auth-setup

Used to provision User, Group and Policy settings into the active cloud account

## Command

    $ axe auth-setup -h
    Basic provisioning of IAM resources for consistent Groups, Policies and Roles on AWS

    Usage:
        axe-auth-setup -e <env-dir> [options]
        axe-auth-setup ( -h | --help )

    Options:
        -c <cb-root>, --cb-root=<cb-root>
                              The $CLOUDBUILDER_ROOT defaults to ~/.cloudbuilder but
                              can be overridden if required. [default: ~/.cloudbuilder]
        -e <env-dir>, --envname=<env-dir>
                              Environment directory for inputs and outputs relative
                              to $CLOUDBUILDER_ROOT including authentication_config.yaml
        -y, --yes             Actually do anything. Otherwise runs in dry-run mode
        -h, --help            show this help message and exit
        --debug               More verbose (usually debug) logging and output


## Example Usage




## Notes


