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
        sudo apt-get insrtall build-essential (Debian/Ubuntu)

 - Activate the local Python

        source $AXE_ROOT/etc/axerc
        pip install -r requirements_py.txt

 - Add the env loading file to your shell config (.bashrc)

        cat >> ~/.bashrc <<-EOF

        AXE_ROOT=$AXE_ROOT
        PATH=\$PATH:\$AXE_ROOT/bin
        export AXE_ROOT PATH

        EOF

 - Add at least one set of personal credentials to your own identity store (Optional)

    it's **very** important that your `aws_mfa_id` is specified as mfa/userid and not user/userid

        mkdir -p ~/.axe/identities
        mkdir -p ~/.axe/identities/<id-name>

        cat > ~/.axe/identities/<id-name>/aws.conf <<-EOF
        [default]
        output = json
        aws_access_key_id=ABCDEFGHIJKLMNOP (Replace with AWS provided KEY)
        aws_secret_access_key=DFGBHTYEJHFKUSPSJDJ22333jdjhfh (Replace with AWS provided Secret KEY)
        aws_mfa_id=arn:aws:iam::AWS-ACCOUNT-ID:mfa/user@hostname.com
        region=eu-west-1

        [preview]
        cloudfront=true
        EOF

        touch ~/.axe/identities/<id-name>/ssh_id.pem (Replace this with you PEM PrivateKey file provided by AWS)


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

 - json2properties.py

> Converts JSON text to Java .properties notation to make programatic parsing easier

    $ bin/tools/json2properties.py -h
    Usage: json2properties.py [options]
      change json to line separated text.
        {a:[8,"b"]}
      is converted
        a.0=8
        a.1="b"

    Example:
      curl -s https://api.github.com/gists/public \
        | $AXE_ROOT/bin/tools/json2properties.py \
        | grep "aaa.bbb"

      aws ec2 describe-instances --filter '{"name":"tag:Name","values":"ft01"}' \
        | $AXE_ROOT/bin/tools/json2properties.py --tsv \
        | awk '/InstanceId/{print $2}'


    Options:
      -s SEP, --sep=SEP  separator of key hierarchy. default '.'
      -e EQ, --eq=EQ     separator of key and value. default '='
      --tsv              format as tsv. ex json{a:{b:1,c:2}} is "a.b\t1\na.c\t2"
      --listkey=LISTKEY  define callback lambda that format list key. lambda has
                         argument name is 'key'. ex: --listkey "'*'"
      -l                 do not print list key. if option defined then
                         json{a:[8,"b"]} is 'a=8 a="b"'. This option is same as
                         set listkey to 'None'
      --format=FORMAT    define callback lambda that format value. lambda has
                         argument name is 'val'. default format is
                         'json.dumps(val)'. ex: --format "'['+str(val)+']'"
      -h, --help         show this help message and exit



 - json2table.py

> Converts JSON to tables in all formats supported by the Python [tabulate](https://pypi.python.org/pypi/tabulate) library

    $ bin/tools/json2table.py -h
    Simple utility script that reads JSON from STDIN and attempts to convert the
    content to a table, before output in a given format. Very useful for the walls
    of text that adding "--output=json" to AWS cli commands generates

    Usage:
        jason2table [options]
        jason2table ( -h | --help )

    Options:
        -f <format>, --format=<format>
                            Supported values are; plain, simple, grid, pipe,
                            orgtbl, rst, mediawiki, latex [default: simple]
        -k, --key=<key>     Object to use a key for array retrieval if JSON contains
                            a dict of lists. If not provided then command will
                            assume that content is an list
        -c, --cols=<cols>   A CSV string specifying the columns from the data to
                            use as a filter before displaying the results
        -h, --help          Show this help message and exit
        --debug             Show more verbose logging



Emulate the output of the `axe image-list` command

    aws ec2 describe-images --owners="self" \
        | ${AXE_ROOT}/bin/tools/json2table.py \
            -k Images \
            -f pipe \
            -c "Architecture,CreationDate,Description,Public,VirtualizationType,Name"


