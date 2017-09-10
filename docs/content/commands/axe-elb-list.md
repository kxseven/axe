
## elb-list

Describes ELBs

### Command

```
usage: axe-elb-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe elb-list

```

**Markdown**
```
$ axe elb-list -f pipe
```




### Notes

 - A set of valid AWS credentials must be loaded for this to work

