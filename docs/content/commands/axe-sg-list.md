
## sg-list

Describes EC2 SecurityGroups

### Command

```
usage: axe-sg-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe sg-list
VpcId         GroupName    Name    GroupId      Description
------------  -----------  ------  -----------  --------------------------
vpc-d75008b3  INS_Bastion  None    sg-76e1940e  Bastion Host
vpc-d75008b3  default      None    sg-4cf7b02a  default VPC security group
```

**Markdown**
```
$ axe sg-list -f pipe
```

| VpcId        | GroupName   | Name   | GroupId     | Description                |
|:-------------|:------------|:-------|:------------|:---------------------------|
| vpc-d75008b3 | INS_Bastion | None   | sg-76e1940e | Bastion Host               |
| vpc-d75008b3 | default     | None   | sg-4cf7b02a | default VPC security group |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

