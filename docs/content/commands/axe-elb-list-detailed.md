
## elb-list-detailed

Describes ELBs with some extra fields

### Command

```
usage: axe-elb-list-detailed [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe elb-list-detailed

```

**Markdown**
```
$ axe elb-list-detailed -f pipe
```




### Notes

 - A set of valid AWS credentials must be loaded for this to work

