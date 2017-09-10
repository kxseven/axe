
## instance-list-detailed

Describes EC2 instances in the current region with additional details extracted from specific Tag pairs

### Command

```
usage: axe-instance-list-detailed [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe instance-list-detailed
VpcId         AZ          SubnetId         Name     BU    BUSub    SystemFunction    Role    OS    Lifecycle    State    InstanceId           PrivateIpAddress    InstanceType    KeyName                ImageId       Virt    PublicIpAddress    Monitoring    auto_start    auto_stop    Description
------------  ----------  ---------------  -------  ----  -------  ----------------  ------  ----  -----------  -------  -------------------  ------------------  --------------  ---------------------  ------------  ------  -----------------  ------------  ------------  -----------  -------------
vpc-d75008b3  eu-west-1c  subnet-19062c7d  bastion  None  None     None              None    None  None         running  i-075a1e32ab7575697  10.199.199.61       t2.micro        eu-west-1-iam-joeblogs  ami-ebd02392  hvm     54.194.24.129      disabled      None          None         None
```

**Markdown**
```
$ axe instance-list-detailed -f pipe
```

| VpcId        | AZ         | SubnetId        | Name    | BU   | BUSub   | SystemFunction   | Role   | OS   | Lifecycle   | State   | InstanceId          | PrivateIpAddress   | InstanceType   | KeyName               | ImageId      | Virt   | PublicIpAddress   | Monitoring   | auto_start   | auto_stop   | Description   |
|:-------------|:-----------|:----------------|:--------|:-----|:--------|:-----------------|:-------|:-----|:------------|:--------|:--------------------|:-------------------|:---------------|:----------------------|:-------------|:-------|:------------------|:-------------|:-------------|:------------|:--------------|
| vpc-d75008b3 | eu-west-1c | subnet-19062c7d | bastion | None | None    | None             | None   | None | None        | running | i-075a1e32ab7575697 | 10.199.199.61      | t2.micro       | eu-west-1-iam-joeblogs | ami-ebd02392 | hvm    | 54.194.24.129     | disabled     | None         | None        | None          |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

