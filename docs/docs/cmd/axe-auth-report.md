# axe-auth-report

Used to list the credentials that are currently provisioned into the active cloud account

## Command

    $ axe auth-report -h
    usage: axe-auth-report [--help] [-f <FORMAT>]

    The output format can be changed by using one of the supported formats:

    plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
    latex_booktabs, tsv (default: simple)

## Example Usage

    $ axe auth-report
    2015-09-09_17:08:47,093 INFO  Generating credential report
    2015-09-09_17:08:48,096 INFO  Downloading credential report for processing
    user            arn                                        user_creation_time         password_enabled    password_last_used         password_last_changed      mfa_active    access_key_1_last_used_date
    --------------  -----------------------------------------  -------------------------  ------------------  -------------------------  -------------------------  ------------  -----------------------------
    <root_account>  arn:aws:iam::123456789123:root             2015-08-14T10:14:20+00:00  not_supported       2015-09-09T13:14:47+00:00  not_supported              false         2015-08-28T10:15:00+00:00
    userjeffk       arn:aws:iam::123456789123:user/userjeffk   2015-08-28T10:17:42+00:00  true                no_information             2015-08-28T10:17:43+00:00  false         N/A
    usermikebe      arn:aws:iam::123456789123:user/usermikebe  2015-08-28T10:17:41+00:00  true                2015-08-28T10:18:00+00:00  2015-08-28T10:18:08+00:00  true          2015-09-07T11:28:00+00:00
    danpo           arn:aws:iam::123456789123:user/danpo       2015-08-28T10:17:43+00:00  true                2015-08-31T10:10:49+00:00  2015-08-28T10:30:47+00:00  false         N/A
    marcode         arn:aws:iam::123456789123:user/marcode     2015-08-28T10:17:42+00:00  true                no_information             2015-08-28T10:17:42+00:00  true          2015-09-07T08:59:00+00:00


## Notes

 - The output can be generated in Markdown by invoking with `-f pipe` for easy documentation

| user           | arn                                       | user_creation_time        | password_enabled   | password_last_used        | password_last_changed     | mfa_active   | access_key_1_last_used_date   |
|:---------------|:------------------------------------------|:--------------------------|:-------------------|:--------------------------|:--------------------------|:-------------|:------------------------------|
| <root_account> | arn:aws:iam::123456789123:root            | 2015-08-14T10:14:20+00:00 | not_supported      | 2015-09-09T13:14:47+00:00 | not_supported             | false        | 2015-08-28T10:15:00+00:00     |
| userjeffk      | arn:aws:iam::123456789123:user/userjeffk  | 2015-08-28T10:17:42+00:00 | true               | no_information            | 2015-08-28T10:17:43+00:00 | false        | N/A                           |
| usermikebe     | arn:aws:iam::123456789123:user/usermikebe | 2015-08-28T10:17:41+00:00 | true               | 2015-08-28T10:18:00+00:00 | 2015-08-28T10:18:08+00:00 | true         | 2015-09-07T11:28:00+00:00     |
| danpo          | arn:aws:iam::123456789123:user/danpo      | 2015-08-28T10:17:43+00:00 | true               | 2015-08-31T10:10:49+00:00 | 2015-08-28T10:30:47+00:00 | false        | N/A                           |
| marcode        | arn:aws:iam::123456789123:user/marcode    | 2015-08-28T10:17:42+00:00 | true               | no_information            | 2015-08-28T10:17:42+00:00 | true         | 2015-09-07T08:59:00+00:00     |
