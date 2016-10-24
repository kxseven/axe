# axe-instance-list

Used to list AWS instances that are accessable from the currently loaded AWS credentials.

## Command

    $ axe instance-list -h
    Basic wrapper script to list AWS instances that are accessable from the
    currently loaded AWS credentials. By default only lists running instances.

    Usage:
        axe-instance-list [options]
        axe-instance-list ( -h | --help )

    Options:
        -v <vpc-name>, --vpc-name=<vpc-name>
                              Display instances in the VPC with matching VPC tag
        -V <vpc-id>, --vpc-id=<vpc-id>
                              Display instances in the matching VPC
        -f <format>, --format=<format>
                             Supported values are; plain, simple, grid, pipe,
                             orgtbl, rst, mediawiki, latex [default: simple]
        -x, --extra-detail   Enable more detailed output
        -h, --help           Show this help message and exit
        --debug              Show more verbose logging


## Example Usage

    $ axe instance-list
    17:59:05 0424 INFO  Initialising AWS Connections
    17:59:05 0430 INFO  Loading credentials from Environment
    17:59:05 0433 INFO  Initializing Boto resources
    Name                         EnvName    State      Util  VpcId         AZ          InstanceId       IP Address     Type          Public IP
    ---------------------------  ---------  -------  ------  ------------  ----------  ---------------  -------------  ------------  ------------
    bossad-pdc.dev.customer.com  WEB-PROD   stopped       0  vpc-12345678  eu-west-1a  subnet-8c5218e9  10.123.12.212  ami-1a92cf6d
    chef.dev.customer.com        WEB-PROD   stopped       0  vpc-12345678  eu-west-1a  subnet-8c5218e9  10.123.12.67   ami-e4ff5c93
    jira.dev.customer.com        WEB-PROD   stopped       0  vpc-12345678  eu-west-1a  subnet-8c5218e9  10.123.12.179  ami-e4ff5c93
    utm-a.dev.customer.com       WEB-PROD   stopped       0  vpc-12345678  eu-west-1a  subnet-8f5218ea  10.123.11.30   ami-a10897d6  52.19.19.199
    bossad-sdc.dev.customer.com  WEB-PROD   stopped       0  vpc-12345678  eu-west-1b  subnet-17661460  10.123.22.126  ami-1a92cf6d
    git.dev.customer.com         WEB-PROD   stopped       0  vpc-12345678  eu-west-1b  subnet-17661460  10.123.22.192  ami-e4ff5c93
    utm-b.dev.customer.com       WEB-PROD   stopped       0  vpc-12345678  eu-west-1b  subnet-2966145e  10.123.21.72   ami-a10897d6  52.18.31.199


## Notes

 - The tool can also be invoked with `-f pipe` to generate Markdown output for easy documentation

| Name                        | EnvName   | State   |   Util | VpcId        | AZ         | InstanceId      | IP Address    | Type         | Public IP    |
|:----------------------------|:----------|:--------|-------:|:-------------|:-----------|:----------------|:--------------|:-------------|:-------------|
| bossad-pdc.dev.customer.com | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1a | subnet-8c5218e9 | 10.123.12.212 | ami-1a92cf6d |              |
| chef.dev.customer.com       | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1a | subnet-8c5218e9 | 10.123.12.67  | ami-e4ff5c93 |              |
| jira.dev.customer.com       | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1a | subnet-8c5218e9 | 10.123.12.179 | ami-e4ff5c93 |              |
| utm-a.dev.customer.com      | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1a | subnet-8f5218ea | 10.123.11.30  | ami-a10897d6 | 52.19.19.199 |
| bossad-sdc.dev.customer.com | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1b | subnet-17661460 | 10.123.22.126 | ami-1a92cf6d |              |
| git.dev.customer.com        | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1b | subnet-17661460 | 10.123.22.192 | ami-e4ff5c93 |              |
| utm-b.dev.customer.com      | WEB-PROD  | stopped |      0 | vpc-12345678 | eu-west-1b | subnet-2966145e | 10.123.21.72  | ami-a10897d6 | 52.18.31.199 |

 - Additional details can also be listed by invoking with `-x`
 - If a VPC-Name is provided with `-v` the tool will attempt to map that value to a `Name` tag for any available VPC in the account that is accessable. If multiple VPCs have the same name then use the `-V` option instead to provide a specific VPC-ID

