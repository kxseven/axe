# axe-env-list

Used to list the virtual machine images that are available to use as starting points, contained within the current cloud account. This does not include the complete marketplace image list but rather only the images that have created within the current cloud account.

## Command

    $ axe image-list -h
    Basic wrapper script to list AWS images that are accessable from the
    currently loaded AWS credentials. By default only lists images in our account

    Usage:
        axe-image-list [options]
        axe-image-list ( -h | --help )

    Options:
        -f <format>, --format=<format>
                             Supported values are; plain, simple, grid, pipe,
                             orgtbl, rst, mediawiki, latex [default: simple]
        -x, --extra-detail   Enable more detailed output
        -h, --help           Show this help message and exit
        --debug              Show more verbose logging


## Example Usage

    $ axe image-list
    Name         CreationDate              ImageId       Arch    Description    Public
    -----------  ------------------------  ------------  ------  -------------  --------
    example-ami  2015-09-09T16:55:08.000Z  ami-4de0c03a  x86_64  CentOS-7-x64   No

## Notes

 - The tool can also be invoked with `-f pipe` to generate Markdown output for easy documentation

| Name        | CreationDate             | ImageId      | Arch   | Description   | Public   |
|:------------|:-------------------------|:-------------|:-------|:--------------|:---------|
| example-ami | 2015-09-09T16:55:08.000Z | ami-4de0c03a | x86_64 | CentOS-7-x64  | No       |

 - Additional details can also be listed by invoking with `-x`

| Name        | CreationDate             | ImageId      | Arch   | Description   | Public   | ImageType   |
|:------------|:-------------------------|:-------------|:-------|:--------------|:---------|:------------|
| example-ami | 2015-09-09T16:55:08.000Z | ami-4de0c03a | x86_64 | CentOS-7-x64  | No       | machine     |

