# Using AXE

The AXE tools are intended to **function similar to `git`** such that;

 - each command is a self-contained tool/script that can be executed atomically if needed
 - valid AXE commands exist as executables in the `$AXE_ROOT/bin/subcommands` directory
 - A parent `axe` tool handles subcommand delegation, including all provided arguments
 - Individual subcommands can exist in a user's PATH that are not part of the default AXE toolset

For more details about the subcommand approach can be found [here](https://www.kernel.org/pub/software/scm/git/docs/howto/new-command.html)

## Load AWS Credentials

!!! warning "Authenticate First!"
    Because almost all of the actions we take will involve querying the AWS API itself, the first thing we need to do is to load an identity and authenticate ourselves in order to make those APi calls.

- Before you use `axe` you have to load the credentials for your chosen identity.
- This is done by using the 'load_aws_credentials' command and selecting the number of the identity you want to use.
- You may be asked for additional authentication, e.g. MFA, if that is required for the identity you've chosen.

    ```
	$ load_aws_credentials

	==================================================================================================
	= Available Identities                                                                           =
	==================================================================================================

	  1 : PERSONAL-example-us-west-2
	  2 : CORP-DEPT-ADFS-example-eu-west-1

	Please select an identity: 1
	INFO : MFA Account Detected... Please specify the MFA PIN Now: 882894
	INFO : AWS_MFA_ID............. arn:aws:iam::AWS-ACCOUNT-ID:mfa/user@hostname.com
	INFO : AWS_TOKEN_EXPIRES...... 2018-06-14 17:57:10
	INFO : AWS_CONFIG_FILE........ /tmp/awsmfaxXcW
	INFO : AWS_SSH_KEY............ /home/vagrant/.axe/identities/PERSONAL-example-us-west-2/ssh_id.pem
	INFO : AWS_DEFAULT_REGION..... us-west-2
	INFO : AWS_ACCESS_KEY_ID...... ABCDEFGHIJKLMNOP
	INFO : AWS_SECRET_ACCESS_KEY.. DFGBHTYEJHFKUSPSJDJ22333jdjhfh
    ```

- The 'load_aws_credentials' command assigns values to the `AWS_` ENVIRONMENT variables.

    ```bash
	$ env | grep AWS
	AWS_SESSION_TOKEN=FQoDYXdzEsdfsadlkjhnsdflsdliiiPPSDFPASDPasdPfasdjasdrasdfsadrjsdfPPfasdjasdlkjrSDASDFsadfASDASDrfasdrsadfAasdFSDwbennyoH4W5G/YsNoRJiY+YiIdVnk/FlDmRxa8VKwR+LQcvdSSLyNdXzSK3UpPQuA3/CqawM6EEDervIyjEo9MHy3oGdkrCpZXIQGOwwIc4i9I2P6ErPOEDAoxHVaoNCq4xJjRMtMp6je1PUAAnzri862Hwo78KK2QU=
	AWS_TOKEN_EXPIRY=1528999030
	AWS_DEFAULT_REGION=us-west-2
	AWS_SECRET_ACCESS_KEY=DFGBHTYEJHFKUSPSJDJ22333jdjhfh
	AWS_MFA_ID=arn:aws:iam::AWS-ACCOUNT-ID:mfa/user@hostname.com
	AWS_ACCESS_KEY_ID=ABCDEFGHIJKLMNOP
	AWS_ID_NAME=PERSONAL-example-us-west-2
	AWS_SECURITY_TOKEN=FQoDYXdzEsdfsadlkjhnsdflsdliiiPPSDFPASDPasdPfasdjasdrasdfsadrjsdfPPfasdjasdlkjrSDASDFsadfASDASDrfasdrsadfAasdFSDwbennyoH4W5G/YsNoRJiY+YiIdVnk/FlDmRxa8VKwR+LQcvdSSLyNdXzSK3UpPQuA3/CqawM6EEDervIyjEo9MHy3oGdkrCpZXIQGOwwIc4i9I2P6ErPOEDAoxHVaoNCq4xJjRMtMp6je1PUAAnzri862Hwo78KK2QU=
	AWS_SSH_KEY=/home/user/.axe/identities/PERSONAL-example-us-west-2/ssh_id.pem
	```


## AXE Commands

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


## AXE Sub Commands

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

| Tool/Command      | Description                                                                                                                                                                  |
|:------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| arnchomp          | Attempts to regex match ARNs and reduce them to only the resource name. Can be used as part of a shell pipeline                                                              |
| arnsplit          | Splits an ARN into multiple tokens, defaulting to the resource token                                                                                                         |
| axegrep           | Based on `kfl` but keeps the first 2 lines which are generally the AXE output header                                                                                         |
| axemap            | Attempts to match text tags to resource IDs for a specific resource type; SG names -to- SG ids                                                                               |
| cache             | Caches the output of the command for up to X mins such that subsequent runs of the same command use the cached output. Useful for caching the output of verbose AWS commands |
| json2orderedtable | Attempts to tabularize JSON input into tabular data, with specific colum sorting                                                                                             |
| json2properties   | Converts JSON to Java Properties syntax                                                                                                                                      |
| json2table        | Attempts to tabularize JSON input into tabular data based on the first keys of a dict or rows in an array                                                                    |
| kfl               | Runs the provided command with args, keeping the first line of the original output. (Useful when the first line contains headers: CSV, etc)                                  |
