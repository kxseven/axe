
## iam-role-list

Describes IAM roles

### Command

```
usage: axe-iam-role-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe iam-role-list
RoleName    CreateDate            Arn
----------  --------------------  ----------------------------------------
DummyRole   2017-09-07T20:41:19Z  arn:aws:iam::123456789012:role/DummyRole
```

**Markdown**
```
$ axe iam-role-list -f pipe
```

| RoleName   | CreateDate           | Arn                                      |
|:-----------|:---------------------|:-----------------------------------------|
| DummyRole  | 2017-09-07T20:41:19Z | arn:aws:iam::123456789012:role/DummyRole |




### Notes

 - A set of valid AWS credentials must be loaded for this to work

