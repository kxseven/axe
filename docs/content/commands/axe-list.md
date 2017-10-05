
## list

Describes various AWS resources by using predefined filters to get and parse the JSON content from the AWS API

### Command

```
usage: axe-list [--help] <resource> [-f <FORMAT>]
       axe-list sg
       axe-list elb -f pipe

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

 - The list of available filters is compiled from all files matching `*.jqf` in both `$AXE_ROOT/etc/filters.d` and `$HOME/.axe/filters` directories
 - This allows you to create your own filters.  `axe list mystuff -f pipe`
 - If a filter is defined in `$HOME/.axe/filters` with the same name as one of the defaults your personal filter will take precedence



### Example Usage

**Simple**
```
$ axe list vpc
VpcId         CidrBlock      Name                    IsDefault
------------  -------------  --------------------  -----------
vpc-12345678  10.10.32.0/20  demo stack                      0
vpc-23456533  10.10.16.0/20  production apps                 0
vpc-34567654  10.10.48.0/24  stress test lab                 0
vpc-23476522  10.10.0.0/20   developer sandbox               0
vpc-1q2w3e4r  10.10.0.0/16   transit vpc                     0
```

**Markdown**
```
$ axe list subnet -f pipe
```

| VpcId        | AvailabilityZone   | CidrBlock      | Name                         | SubnetId        |   AvailableIpAddressCount |
|:-------------|:-------------------|:---------------|:-----------------------------|:----------------|--------------------------:|
| vpc-23456533 | eu-west-1a         | 10.10.10.0/24  | TRANSIT-RedA                 | subnet-38c5e05d |                       244 |
| vpc-23456533 | eu-west-1a         | 10.10.11.0/24  | TRANSIT-AmberA               | subnet-3ec5e05b |                       246 |
| vpc-23456533 | eu-west-1a         | 10.10.12.0/24  | TRANSIT-GreenA               | subnet-3bc5e05e |                       250 |
| vpc-23456533 | eu-west-1b         | 10.10.20.0/24  | TRANSIT-RedB                 | subnet-29612c5e |                       250 |
| vpc-23456533 | eu-west-1b         | 10.10.21.0/24  | TRANSIT-AmberB               | subnet-1e612c69 |                       250 |
| vpc-23456533 | eu-west-1b         | 10.10.22.0/24  | TRANSIT-GreenB               | subnet-17612c60 |                       251 |
| vpc-23456533 | eu-west-1c         | 10.10.30.0/24  | TRANSIT-RedC                 | subnet-2db7d374 |                       250 |
| vpc-23456533 | eu-west-1c         | 10.10.31.0/24  | TRANSIT-AmberC               | subnet-25b7d37c |                       251 |
| vpc-23456533 | eu-west-1c         | 10.10.32.0/24  | TRANSIT-GreenC               | subnet-2cb7d375 |                       251 |


### Notes

 - A set of valid AWS credentials must be loaded for this to work


### Defining your own filters

The filters are [jq] compatible filters and must follow the following patterns;

 - The filename must end in `.jqf`. The rest of the filename is used as the filter name (`my-special-filter.jqf` becomes available as `axe list my-special-filter`)
 - The aws-cli command used to get source data is specified in a special comment `#cmd: <whatever>`
 - The output can be sorted by specific column names provided in a special comment `#sort: <sort order>`
 - The resulting output must be a series of dict items which are then assembled into an array before being converted to tabular format

```
#cmd: ec2 describe-images --owners self
#sort: Name,CreationDate

.Images | .[]? | {
    Name,
    CreationDate,
    ImageId,
    Architecture,
    VirtualizationType,
    Description: (.Description // "None"),
    Public
}
```

 - You can test your new filter by invoking the full pipeline manually

```
aws ec2 describe-images --owners self \
    | jq -f <path-to-filter-file> \
    | jq -s '.' | $AXE_ROOT/bin/tools/json2table
```

[jq]: https://stedolan.github.io/jq/
