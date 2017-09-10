
## auth-list-keys

Describes the API keys and the users they are associated with

### Command

```
usage: axe-auth-list-keys [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe auth-list-keys
Username      Status     Created Date          API Key
-----------  ---------  --------------------  --------------------
iamauser     Active     2015-07-15T07:57:32Z  ABCDEFGHIJKLMNOPQRST
iamreadonly  Inactive   2017-01-24T11:23:55Z  ABCDEFGHIJKLMNOPQRSU
```

**Markdown**
```
$ axe auth-list-keys -f pipe
```

| Username    |  Status   |  Created Date        |  API Key             |
|:------------|:----------|:---------------------|:---------------------|
| iamauser    | Active    | 2015-07-15T07:57:32Z | ABCDEFGHIJKLMNOPQRST |
| iamreadonly | Inactive  | 2017-01-24T11:23:55Z | ABCDEFGHIJKLMNOPQRSU |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

