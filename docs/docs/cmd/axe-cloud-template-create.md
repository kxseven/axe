# axe-cloud-template-create

Used to create an AWS CloudFormation stack template based on a specified stack configuration

## Command

    $ axe cloud-template-create -h
    Basic Template Builder for AWS VPC to generate basic AWS CloudFormation
    format templates.

    Usage:
        axe-cloud-template-create -e <env-dir> [options]
        axe-cloud-template-create ( -h | --help )

    Options:
        -c <cb-root>, --cb-root=<cb-root>
                              The $CLOUDBUILDER_ROOT defaults to ~/.cloudbuilder but
                              can be overridden if required. [default: ~/.cloudbuilder]
        -e <env-dir>, --envname=<env-dir>
                              Environment directory for inputs and outputs relative
                              to $CLOUDBUILDER_ROOT including a stack_config.yaml
                              which will contain tags, subnets and more
        -h, --help            show this help message and exit
        --debug               More verbose (usually debug) logging and output


## Example Usage

    $ axe cloud-template-create -e customer/example/prod


## Notes

 - A CloudFormation template will be output into the `customer/example/prod` directory after passing validation against the AWS CloudFormation template syntax
 - Once created the CloudFormation template can then be uploaded into the AWS console to create the network fabric for your virtualized stack
