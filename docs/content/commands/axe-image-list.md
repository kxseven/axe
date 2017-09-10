
## image-list

Describe the AMIs for the current region

### Command

```
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
```

### Example Usage

**Simple**
```
$ axe image-list
Name           CreationDate              ImageId       Arch    Description                            Public
-------------  ------------------------  ------------  ------  -------------------------------------  --------
example-image  2017-09-07T20:44:20.000Z  ami-a68046df  x86_64  An example image from an EC2 instance  No
```

**Markdown**
```
$ axe image-list -f pipe
```

| Name          | CreationDate             | ImageId      | Arch   | Description                           | Public   |
|:--------------|:-------------------------|:-------------|:-------|:--------------------------------------|:---------|
| example-image | 2017-09-07T20:44:20.000Z | ami-a68046df | x86_64 | An example image from an EC2 instance | No       |



### Notes

 - A set of valid AWS credentials must be loaded for this to work

