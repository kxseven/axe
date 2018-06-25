# Installing AXE

## Before you start

!!! tip "Do you need Kerberos/ActiveDirectory Support?"
    You may need to install OS packages before performing the steps described in "[Getting Started](#getting-started)". For convenience the installation for OS packages is described in the "[Troubleshooting](/content/user-guide/troubleshooting/)" section at the end of this guide

**Core Utilities**

In order to use the core AXE tools you will need the tools/software below.

| Requirement              | Notes                                                                      |
|:-------------------------|:---------------------------------------------------------------------------|
| BASH shell               | Built into Linux distros, Part of the Git SCM for Windows install          |
| Git SCM                  | [http://www.git-scm.com/downloads](http://www.git-scm.com/downloads)       |
| Python 2.7 or Python 3.x | [https://www.python.org/downloads/](https://www.python.org/downloads/)     |
| Python Pip               | [http://pypi.python.org/pypi/pip](http://pypi.python.org/pypi/pip)         |
| Python Virtualenv*       | [https://github.com/pypa/virtualenv/](https://github.com/pypa/virtualenv/) |
| jq                       | [https://stedolan.github.io/jq/](https://stedolan.github.io/jq/)           |

!!! tip "Hatch instead of Virtualenv"
    You may want to use the [hatch] utility instead of virtualEnv. I haven't had time to test all of the functionality using a hatch environment but it may be useful to have a single "Cloud" environment for hatch instead of many virtualenvs, one for each 'tool'

[hatch]: https://github.com/ofek/hatch

**Optional Extras**

Some of the additional tools in the AXE repo require additional dependencies.

| AXE Command                   | Requirement                        | Notes                                                                                                   |
|:------------------------------|:-----------------------------------|:--------------------------------------------------------------------------------------------------------|
| axe dump-account              | Ruby Gem - terraforming            | [Grab it here](https://github.com/dtan4/terraforming). Can be installed with `gem install terraforming` if you have a working Ruby install |
| axe token-krb5formauth-create | Kerberos support for OS and Python | Can be installed by following the [Installing OS deps](#installing-os-packages-for-dependencies) section below |
| axe vpc-viz                   | Graphviz                           | [Grab it here](http://www.graphviz.org/download/). Can be installed by following the [Installing OS deps](#installing-os-packages-for-dependencies) section below |


## Installing AXE

!!! warning "Prefer OS packages"
    While many of the Python packages needed can be installed using `pip` I would recommend taking advantage of the
    binary packages available to your OS if they're available to avoid having to install the "Development Tools" and
    compiling from source. If you have issues installing the Python packages using `pip` try installing the OS provided
    packages first

 - Install required OS packages

    **CentOS/RHEL**
    ```
    sudo yum install epel-release -y
    sudo yum install -y \
        krb5-devel \
        python-gssapi \
        python-kerberos \
        python-requests-kerberos \
        python-simplejson \
        bash-completion \
        python2-pip \
        python-virtualenv \
        git \
        jq \
        graphviz*
    ```

    **Debian/Ubuntu**
    ```
    sudo apt-get install -y \
        libkrb5-dev \
        python-gssapi \
        python-kerberos \
        python-requests-kerberos \
        python-simplejson \
        bash-completion \
        python-pip \
        virtualenv \
        git \
        jq \
        graphviz
    ```

 - Cloning the Git repo

    ```
    git clone https://bitbucket.org/kxseven/axe.git
    cd axe
    AXE_ROOT=$(pwd)
    export AXE_ROOT
    ```

 - Create a VirtualEnv (Python v2.7) to hold AXE requirements

    ```
    cd $AXE_ROOT
    virtualenv local/python
    ```

 - Activate the virtualenv Python

    ```
    source $AXE_ROOT/etc/axerc
    pip install -r requirements/requirements.python2
    ```

 - Add the env loading file to your shell config (.bashrc)

    ```
    cat >> ~/.bashrc <<-EOF

    # AXE Environment
    AXE_ROOT=$AXE_ROOT
    PATH=\$PATH:\$AXE_ROOT/bin
    export AXE_ROOT PATH
    # Useful alias
    alias goaxe='cd \$AXE_ROOT; . etc/axerc'

    EOF
    ```

 - Deactive the VirtualEnv and log back in again to verify that all works as expected by triggering the `goaxe` helper

    ```
    goaxe
    (python)[vagrant@jumphost01 axe]axe -h
    usage: axe [--version] [--help] <command> [<args>]

    available commands in '/home/vagrant/axe/bin/subcommands'

    auth-list-keys                  kms-key-list
    auth-report                     scp
    docs                            sg-add
    dump-account                    sg-create
    elb-list                        sg-list
    elb-list-detailed               ssh
    iam-cert-list                   subnet-claim-ip
    iam-role-list                   subnet-list
    image-list                      token-krb5formauth-create
    instance-create                 token-mfaauth-create
    instance-list                   vpc-list
    instance-list-detailed          whoami
    ```

## Configuring Identities in AXE

!!! note "AWS Configuration"
    The identity configuration for AXE re-uses the configuration already supported by the [AWS CLI described here](http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)

 - Start by creating a directory in which to store your id

    ```
    mkdir -p ~/.axe/identities
    mkdir -p ~/.axe/identities/<id-name>
    ```

 - If you don't have your SSH key to hand you can simply create an empty file for now and replace this with you PEM PrivateKey file provided by AWS

    ```
    touch ~/.axe/identities/<id-name>/ssh_id.pem
    ```

### API Credentials

 - A basic API keys based identity uses two files; 1) AWS Config, 2) A valid private key for use when using axe-ssh or axe-scp

    ```
    $HOME/.axe/identities/
              ├── PERSONAL-example-us-west-2
              │   ├── aws.conf
              │   └── ssh_id.pem
    ```

 - Add at least one set of personal credentials to your own identity store.

    ```ini
    [default]
    output=json
    aws_access_key_id=ABCDEFGHIJKLMNOP
    aws_secret_access_key=DFGBHTYEJHFKUSPSJDJ22333jdjhfh
    region=eu-west-1

    [preview]
    cloudfront=true
    ```


### API Credentials with MFA

!!! warning "Credentials Expire after 4 Hours"
    Identities that load and generate temporary credentials are created with a fixed expiry. This is described [here in the AWS docs](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetSessionToken.html). Although the new default is to expire credentials in 12 hours the **AXE tools default to requesting expiry after four hours**

!!! warning "aws_mfa_id"
    It's **very** important that your `aws_mfa_id` is specified as `mfa/userid` and not `user/userid`. If copying your username from the AWS console it will be in the `user/userid` format.

 - A basic MFA identity uses two files; 1) AWS Config, 2) A valid private key for use when using axe-ssh or axe-scp

    ```
    $HOME/.axe/identities/
              ├── PERSONAL-example-us-west-2
              │   ├── aws.conf
              │   └── ssh_id.pem
    ```

 - Add at least one set of personal credentials to your own identity store.

    ```ini
    [default]
    output=json
    aws_access_key_id=ABCDEFGHIJKLMNOP
    aws_secret_access_key=DFGBHTYEJHFKUSPSJDJ22333jdjhfh
    aws_mfa_id=arn:aws:iam::AWS-ACCOUNT-ID:mfa/user@hostname.com
    region=eu-west-1

    [preview]
    cloudfront=true
    ```


### API Credentials using Kerberos/Active Directory SAML2

!!! warning "Credentials Expire after 4 Hours"
    Identities that load and generate temporary credentials are created with a fixed expiry. This is described [here in the AWS docs](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetSessionToken.html). Although the new default is to expire credentials in 12 hours the **AXE tools default to requesting expiry after four hours**

 - This is used for when access to the portal that generates SAML2 tokens requires an authenticated Kerberos token     itself which is common in corporate/enterprise environments that make use of an IDP so that Active Directory     credentials can be uplifted to provide access to predefined roles in AWS IAM via federated login

 - The folder structure is slightly different and needs to contain an `idp_params.json` file that configures which parameters are needed from the Federated Identity Provider

    ```
    $HOME/.axe/identities/
              ├── CORP-DEPT-ADFS-example-eu-west-1
              │   ├── aws.conf
              │   ├── idp_params.json
              │   └── ssh_id.pem
    ```

 - The `aws.conf` is as follows

    ```ini
    [default]
    output=json
    aws_access_key_id=
    aws_secret_access_key=
    aws_idp_url='https://special-URL-that-triggers-SAML-authentication/from/your/company/to/aws'
    aws_idp_principal=YOURID@YOURCORP.COM
    region=eu-west-1

    [preview]
    cloudfront=true
    ```

 - The `idp_params.json` contains any form fields and respective values that need to be provided when accessing the SAML URL. The entries in this file need to correspond to the names of the form fields

    ```json
    {
        "special_username": "joe.dummy@corp.com",
        "special_password": "blah",
        "hidden_field": "credential"
    }
    ```

 - A value of `<ask>` can be specified in the JSON value to have the script ask the user at runtime.

 - A value of `<password>` can be specified to have the user provide input and not echo the text (Useful for passwords)

 - Generally when loading SAML2 based identities the Kerberos session needs to be initialized first to avoid getting errors when attempting to access the form.

        ERROR: I can't protect from your own stupidity. No Kerberos token found. Start with kinit
        ERROR: Valid credentials not found in /tmp/awsmfaiF1l. Token generation failed

 - Initialize your Kerberos session using `kinit MY-REALM-ID@MY-CORP.COM -V`


## Installing OS packages for dependencies

**CentOS/RHEL**
```
sudo yum groupinstall "Development Tools"
sudo yum install -y epel-release
sudo yum install -y python2-pip python-virtualenv git
sudo yum install -y krb5-devel openssl-devel libffi-devel python-devel
```

**Debian/Ubuntu**
```
sudo apt-get install -y build-essential
sudo apt-get install -y python-pip virtualenv git
sudo apt-get install -y libkrb5-dev libssl-dev libffi-dev python-dev
```
