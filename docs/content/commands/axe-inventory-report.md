
## inventory-report

Describes the resource inventory within the AWS account and region based on the list of available resource filters (From `axe list`). As more filters are added to AXE then report will get more complete.

### Command

```
usage: axe-inventory-report [-h] [-f <FORMAT>] [-d <OUTPUT-DIR>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

 - The list of available filters is compiled from all valid filters used by the `axe list` sub-command. See [usage](/content/commands/axe-list/) for more info
 - The HTML format report uses a Bootstrap enabled template


### Example Usage

**Default Report**
```
$ axe inventory-report
```

**Markdown Report**
```
$ axe inventory-report -f pipe
```

**HTML Report**
```
$ axe inventory-report -f html
```

### Notes

 - A set of valid AWS credentials must be loaded for this to work


