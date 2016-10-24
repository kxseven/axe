# AXE - The Cloud Hatchet

In order to make best use of the docs in this repo it's best to install the 'mkdocs' utility. Once installed you can just run `mkdocs serve` from the docs directory and read the rest from there. This is intentional so that the docs function even when offline and no access to the Internet is available as long as you have at least a working copy from the repo itself

Alternatively you can simply browse to the **docs** folder in the repo.

## Introduction

The goal of the AXE tools is to help with the construction of your virtual data-center to help you reach a point where other automation tools can then take over in a repeatable, versionable manner. You may already have Chef, Puppet, Ansible, Salt or your own tools that you use to manage server instances which can then compliment the AXE tools.

### Components

The AXE toolset is seperated into three distinct components;

1. The AXE tools themselves
2. Credential management that manipulates the active identity to facilitate multiple sets of credentials across many separate stacks
3. Stack management so that each stack can be managed and versioned independantly of both the tools and the credentials that have access to manipulate those resources

![AXE Components](https://bitbucket.org/kxseven/axe/raw/master/docs/docs/media/images/axe_trio.png)


### How it fits together

 - Users use the AXE tools to load specific identities that contain valid credentials for one or more cloud providers
 - Users use the AXE tools to read/display the contents of existing deployed stacks
 - Users provide partial/complete stack configurations to the tools that help construct stack virtual infrastructure on cloud providers to the point at which other automation tools can take over
 - Some of the tools in AXE can be combined with stack configurations to provide the initial pieces of an overall CI tool-chain

![AXE Trio Workflow](https://bitbucket.org/kxseven/axe/raw/master/docs/docs/media/images/axe_trio_flow.png)


## Minimum Requirements

In order to use the AXE tools you will need the following;

| Requirement | Notes |
|:------------|:------|
| Git SCM     | [download here](http://www.git-scm.com/downloads) |
| BASH shell  | Built into Linux distros, Part of the Git-for-Windows in the link above |
| Python 2.7 or Python 3.x | [download here](https://www.python.org/downloads/) |
| Python Pip  | [download here](http://pypi.python.org/pypi/pip) |


Some of the additional tools in the AXE repo require use of Ruby Gems, which aside from being a blight on the humanity of IT are occasionally useful.

| AXE Tool                      | Requirement                        | Notes |
|:------------------------------|:---------------------------------- |:----- |
| axe dump-account              | Ruby Gem - terraforming            | [Grab it here](https://github.com/dtan4/terraforming). Can be installed with `gem install terraforming` |
| axe token-krb5formauth-create | Kerberos support for OS and Python | Can be installed with `sudo apt-get install krb5-userlibkrb5-dev` |


## Getting Started with the AXE tool-chain

On the assumption that you have a Ubuntu based OS with a working version of git and Python 2.7 you can grab a copy by;

 - Cloning the Git repo

        git clone git@bitbucket.org:kxseven/axe.git
        cd axe; AXE_ROOT=$(pwd); export AXE_ROOT;

 - Install VirtualEnv (Python v2.7)

        sudo apt-get install python-virtualenv python-dev (or pip install virtualenv)
        cd $AXE_ROOT; virtualenv local/python

 - Install build tools for Python module creation

        sudo yum groupinstall "Development Tools" (RHEL/CentOS)
        sudo apt-get install build-essential (Debian/Ubuntu)

 - Install packages needed for Kerberos based authentication

        sudo yum install gcc libffi-devel python-devel openssl-devel (RHEL/CentOS)
        sudo apt-get install python-gssapi python-kerberos python-requests-kerberos libkrb5-dev libssl-dev libffi-dev python-dev (Debian/Ubuntu)

 - Activate the local Python

        source $AXE_ROOT/etc/axerc
        pip install -r requirements_py.txt

 - Add the env loading file to your shell config (.bashrc)

        cat >> ~/.bashrc <<-EOF

        AXE_ROOT=$AXE_ROOT
        PATH=\$PATH:\$AXE_ROOT/bin
        export AXE_ROOT PATH

        EOF

 - Deactive the VirtualEnv and log back in again to verify that all works as expected.

## Configuring Identities in AXE

 - Start by creating a directory in which to store your id

        mkdir -p ~/.axe/identities
        mkdir -p ~/.axe/identities/<id-name>

 - If you don't have your SSH key to hand you can simply create an empty file for now and replace this with you PEM PrivateKey file provided by AWS

        touch ~/.axe/identities/<id-name>/ssh_id.pem


### MFA Based Identity

 - A basic MFA identity uses two files; 1) AWS Config, 2) A valid private key for use when using axe-ssh or axe-scp

        $HOME/.axe/
                  ├── PERSONAL-example-us-west-2
                  │   ├── aws.conf
                  │   └── ssh_id.pem

 - Add at least one set of personal credentials to your own identity store. It's **very** important that your `aws_mfa_id` is specified as mfa/userid and not user/userid

        [default]
        output = json
        aws_access_key_id=ABCDEFGHIJKLMNOP (Replace with AWS provided KEY)
        aws_secret_access_key=DFGBHTYEJHFKUSPSJDJ22333jdjhfh (Replace with AWS provided Secret KEY)
        aws_mfa_id=arn:aws:iam::AWS-ACCOUNT-ID:mfa/user@hostname.com
        region=eu-west-1

        [preview]
        cloudfront=true

### Kerberos authenticated IAM Role using SAML2

 - The folder structure is slightly different and needs to contain an `idp_params.json` file that configures which parameters are needed from the Federated Identity Provider

        $HOME/.axe/
                  ├── CORP-DEPT-ADFS-example-eu-west-1
                  │   ├── aws.conf
                  │   ├── idp_params.json
                  │   └── ssh_id.pem


 - The `aws.conf` is as follows

        [default]
        output = json
        aws_access_key_id=
        aws_secret_access_key=
        aws_idp_url='https://special-URL-that-triggers-SAML-authentication/from/your/company/to/aws'
        aws_idp_principal=YOURID@YOURCORP.COM
        region=eu-west-1

        [preview]
        cloudfront=true

 - The `idp_params.json` contains any form fields and respective values that need to be provided when accessing the SAML URL

        {
            "special_username": "joe.dummy@corp.com",
            "special_password": "blah",
            "hidden_field": "credential"
        }

 - A value of `<ask>` can be specified in the JSON value to have the script ask the user at runtime.

 - A value of `<password>` can be specified to have the user provide input and not echo the text (Useful for passwords)

 - Generally when loading SAML2 based identities the Kerberos session needs to be initialized first to avoid getting errors when attempting to access the form.

        ERROR: I can't protect from your own stupidity. No Kerberos token found. Start with kinit
        ERROR: Valid credentials not found in /tmp/awsmfaiF1l. Token generation failed

 - Initialize your Kerberos session using `kinit MY-REALM-ID@MY-CORP.COM -V`


## AXE Commands

### Sub Commands

Each of the AXE commands exists as a stand-along scriptlet in `$AXE_ROOT/bin/subcommands/`. All of the currently available AXE commands can be displayed using `axe -h`

    user@host$> axe -h
    usage: axe [--version] [--help] <command> [<args>]

    available commands in '/home/hmooney/workspace/work-version1/project-axe/bin/subcommands'

    auth-list-keys                  get-vols-by-id
    auth-report                     grafana-build-dashboards
    auth-setup                      image-list
    auth-token-create               instance-create
    cloud-template-create           instance-list
    docs                            scp
    dump-account                    ssh
    env-list


### Tool Commands

There are additional utility scriptlets in `$AXE_ROOT/bin/tools/` which are intended to be helper scripts for processing AWS data at the command line.

| Tool/Command           | Description     |
|:---------------------- |:--------------- |
| kfl                    | Runs the provided command with args, keeping the first line of the original output. (Useful when the first line contains headers: CSV, etc) |
| axegrep                | Based on `kfl` but keeps the first 2 lines which are generally the AXE output header |
| axemap                 | Attempts to match text tags to resource IDs for a specific resource type; SG names -to- SG ids |
| cache                  | Caches the output of the command for up to X mins such that subsequent runs of the same command use the cached output. Useful for caching the output of verbose AWS commands |
| json2properties        | Converts JSON to Java Properties syntax |
| json2table             | Attempts to tabularize JSON input into tabular data based on the first keys of a dict or rows in an array |

