
## s3-bucket-size

Describe the size of S3 Buckets

### Command

```
usage: axe-s3-bucket-size [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe s3-bucket-size
Name                                               Size (GB)
-----------------------------------------------  -----------
cloudtrail-my-special-project                           0.01
config-bucket-123456765443                              0.01
webapp-elb-prod-logs                                    2.18
```

**Markdown**
```
$ axe s3-bucket-size -f pipe
```

| Name                                            |   Size (GB) |
|:------------------------------------------------|------------:|
| cloudtrail-my-special-project                   |        0.01 |
| config-bucket-123456765443                      |        0.01 |
| webapp-elb-prod-logs                            |        2.18 |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

