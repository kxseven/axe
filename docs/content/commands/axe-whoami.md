
## whoami

Describe the currently active API credentials

### Command

```
usage: axe-whoami [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe whoami
     Account  UserId                 Arn
------------  ---------------------  -----------------------------------------
123456789012  AIDAHGTSVRPYC6OUTPSWG  arn:aws:iam::123456789012:user/iamauserdf
```

**Markdown**
```
$ axe whoami -f pipe
```

|      Account | UserId                | Arn                                       |
|-------------:|:----------------------|:------------------------------------------|
| 123456789012 | AIDAHGTSVRPYC6OUTPSWG | arn:aws:iam::123456789012:user/iamauserdf |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

