
## kms-key-list

Describe KMS keys

### Command

```
usage: axe-kms-key-list [--help] [-f <FORMAT>]

The output format can be changed by using one of the supported formats:

plain, simple, grid, fancy_grid, pipe, orgtbl, rst, mediawiki, html, latex,
latex_booktabs, tsv (default: simple)
```

### Example Usage

**Simple**
```
$ axe kms-key-list
Origin    KeyId                                 Description                                                                     Enabled  KeyUsage         KeyState      CreationDate  Arn                                                                            AWSAccountId
--------  ------------------------------------  ----------------------------------------------------------------------------  ---------  ---------------  ----------  --------------  ---------------------------------------------------------------------------  --------------
AWS_KMS   1a5c2ad6-10cc-4c03-bdc8-4c9a7c15012b  Default master key that protects my EBS volumes when no other key is defined          1  ENCRYPT_DECRYPT  Enabled        1.4889e+09   arn:aws:kms:eu-west-1:337287605720:key/1a5c2ad6-10cc-4c03-bdc8-4c9a7c15012b    337287605720
AWS_KMS   6ab3085e-fa55-409c-8846-dd5d1a1b7d35  Default master key that protects my S3 objects when no other key is defined           1  ENCRYPT_DECRYPT  Enabled        1.48949e+09  arn:aws:kms:eu-west-1:337287605720:key/6ab3085e-fa55-409c-8846-dd5d1a1b7d35    337287605720
```

**Markdown**
```
$ axe kms-key-list -f pipe
```

| Origin   | KeyId                                | Description                                                                  |   Enabled | KeyUsage        | KeyState   |   CreationDate | Arn                                                                         |   AWSAccountId |
|:---------|:-------------------------------------|:-----------------------------------------------------------------------------|----------:|:----------------|:-----------|---------------:|:----------------------------------------------------------------------------|---------------:|
| AWS_KMS  | 1a5c2ad6-10cc-4c03-bdc8-4c9a7c15012b | Default master key that protects my EBS volumes when no other key is defined |         1 | ENCRYPT_DECRYPT | Enabled    |    1.4889e+09  | arn:aws:kms:eu-west-1:337287605720:key/1a5c2ad6-10cc-4c03-bdc8-4c9a7c15012b |   337287605720 |
| AWS_KMS  | 6ab3085e-fa55-409c-8846-dd5d1a1b7d35 | Default master key that protects my S3 objects when no other key is defined  |         1 | ENCRYPT_DECRYPT | Enabled    |    1.48949e+09 | arn:aws:kms:eu-west-1:337287605720:key/6ab3085e-fa55-409c-8846-dd5d1a1b7d35 |   337287605720 |


### Notes

 - A set of valid AWS credentials must be loaded for this to work

