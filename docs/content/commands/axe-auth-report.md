
## auth-report

Describes the current list of IAM users and details about their credential usage

### Command

```
usage: axe-auth-report [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe auth-report
user            arn                                         user_creation_time         password_enabled    password_last_used         password_last_changed      mfa_active    access_key_1_last_used_date
--------------  ------------------------------------------  -------------------------  ------------------  -------------------------  -------------------------  ------------  -----------------------------
<root_account>  arn:aws:iam::123456789012:root              2010-02-14T05:53:02+00:00  not_supported       2017-09-07T18:59:59+00:00  not_supported              true          N/A
iamauser        arn:aws:iam::123456789012:user/iamauser     2015-07-15T07:57:32+00:00  true                2017-08-23T07:21:12+00:00  2017-01-09T15:58:55+00:00  true          2017-09-07T19:01:00+00:00
iamreadonly     arn:aws:iam::123456789012:user/iamreadonly  2017-01-24T11:23:54+00:00  false               N/A                        N/A                        false         2017-03-16T15:02:00+00:00
```

**Markdown**
```
$ axe auth-report -f pipe
```

| user           | arn                                        | user_creation_time        | password_enabled   | password_last_used        | password_last_changed     | mfa_active   | access_key_1_last_used_date   |
|:---------------|:-------------------------------------------|:--------------------------|:-------------------|:--------------------------|:--------------------------|:-------------|:------------------------------|
| <root_account> | arn:aws:iam::123456789012:root             | 2010-02-14T05:53:02+00:00 | not_supported      | 2017-09-07T18:59:59+00:00 | not_supported             | true         | N/A                           |
| iamauser       | arn:aws:iam::123456789012:user/iamauser    | 2015-07-15T07:57:32+00:00 | true               | 2017-08-23T07:21:12+00:00 | 2017-01-09T15:58:55+00:00 | true         | 2017-09-07T19:01:00+00:00     |
| iamreadonly    | arn:aws:iam::123456789012:user/iamreadonly | 2017-01-24T11:23:54+00:00 | false              | N/A                       | N/A                       | false        | 2017-03-16T15:02:00+00:00     |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

