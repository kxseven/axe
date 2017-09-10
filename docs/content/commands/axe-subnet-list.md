
## subnet-list

Describe VPC subnets

### Command

```
usage: axe-subnet-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe subnet-list
VpcId         AvailabilityZone    CidrBlock          Name             SubnetId           AvailableIpAddressCount
------------  ------------------  -----------------  ---------------  ---------------  -------------------------
vpc-d75008b3  eu-west-1a          10.199.199.128/26  sandbox-green-a  subnet-a70435d1                         59
vpc-d75008b3  eu-west-1a          10.199.199.64/26   sandbox-red-a    subnet-c80435be                         59
vpc-d75008b3  eu-west-1c          10.199.199.0/26    sandbox-red-c    subnet-19062c7d                         58
vpc-d75008b3  eu-west-1c          10.199.199.192/26  sandbox-green-c  subnet-cb566baf                         59
```

**Markdown**
```
$ axe subnet-list -f pipe
```

| VpcId        | AvailabilityZone   | CidrBlock         | Name            | SubnetId        |   AvailableIpAddressCount |
|:-------------|:-------------------|:------------------|:----------------|:----------------|--------------------------:|
| vpc-d75008b3 | eu-west-1a         | 10.199.199.128/26 | sandbox-green-a | subnet-a70435d1 |                        59 |
| vpc-d75008b3 | eu-west-1a         | 10.199.199.64/26  | sandbox-red-a   | subnet-c80435be |                        59 |
| vpc-d75008b3 | eu-west-1c         | 10.199.199.0/26   | sandbox-red-c   | subnet-19062c7d |                        58 |
| vpc-d75008b3 | eu-west-1c         | 10.199.199.192/26 | sandbox-green-c | subnet-cb566baf |                        59 |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

