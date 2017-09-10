
## instance-list

Describes EC2 instances in the current region

### Command

```
usage: axe-instance-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe instance-list
VpcId         AZ          SubnetId         Name     State    InstanceId           PrivateIpAddress    InstanceType    KeyName                PublicIpAddress    Description
------------  ----------  ---------------  -------  -------  -------------------  ------------------  --------------  ---------------------  -----------------  -------------
vpc-d35008b3  eu-west-1c  subnet-19062c7d  bastion  running  i-045a1e32ab7575697  10.199.199.61       t2.micro        eu-west-1-iam-joeblogs  54.194.24.129      None
```

**Markdown**
```
$ axe instance-list -f pipe
```

| VpcId        | AZ         | SubnetId        | Name    | State   | InstanceId          | PrivateIpAddress   | InstanceType   | KeyName               | PublicIpAddress   | Description   |
|:-------------|:-----------|:----------------|:--------|:--------|:--------------------|:-------------------|:---------------|:----------------------|:------------------|:--------------|
| vpc-d35008b3 | eu-west-1c | subnet-19062c7d | bastion | running | i-045a1e32ab7575697 | 10.199.199.61      | t2.micro       | eu-west-1-iam-joeblogs | 54.194.24.129     | None          |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

