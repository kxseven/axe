
## iam-cert-list

Describes the list of SSL certificates currently added to your AWS account. These are commonly used for ELB or CDN endpoints

### Command

```
usage: axe-iam-cert-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe iam-cert-list

```

**Markdown**
```
$ axe iam-cert-list -f pipe
```




### Notes

 - A set of valid AWS credentials must be loaded for this to work

