
## vpc-list

Describe VPCs

### Command

```
usage: axe-vpc-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe vpc-list
VpcId         CidrBlock        Name               IsDefault
------------  ---------------  ---------------  -----------
vpc-d75008b3  10.199.199.0/24  private-sandbox            0
```

**Markdown**
```
$ axe vpc-list -f pipe
```

| VpcId        | CidrBlock       | Name            |   IsDefault |
|:-------------|:----------------|:----------------|------------:|
| vpc-d75008b3 | 10.199.199.0/24 | private-sandbox |           0 |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

