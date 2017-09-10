
## token-mfaauth-create

Attempts to get valid AWS session credentials using MFA based authentication

!!! warning "Internal but useful for troubleshooting"
    This AXE command is used internally to load identity profiles which are then used to request API access. Generally only useful when troubleshooting issues with MFA

### Command

```
Basic script to provide AWS Session Tokens

Usage:
    axe-token-mfaauth-create <access_key> <secret_key> <mfa_serial_number> <mfa_token> [ --debug ]
    axe-token-mfaauth-create ( -h | --help )
```

### Example Usage

**Simple**
```
$ axe token-mfaauth-create 'AKIAILA5HGSTJGH4W3QQ' '455322222JJWjsikcS1VAQXItEV0sd+34AmZv9E9bW' 'arn:aws:iam::123456789021:mfa/iamamfauser' 039743
2017-01-11 13:28:40,543 DEBUG Requesting credentials
2017-01-11 14:30:42,230 DEBUG command-line options: <role_arn>: arn:aws:iam::123456789021:role/aws_developer
2017-01-11 14:30:42,231 DEBUG command-line options: <mfa_token>: 039743
2017-01-11 14:30:42,231 DEBUG command-line options: -h: False
2017-01-11 14:30:42,231 DEBUG command-line options: <secret_key>: 455322222JJWjsikcS1VAQXItEV0sd+34AmZv9E9bW
2017-01-11 14:30:42,231 DEBUG command-line options: <mfa_serial_number>: arn:aws:iam::123456789021:mfa/iamamfauser
2017-01-11 14:30:42,231 DEBUG command-line options: --debug: True
2017-01-11 14:30:42,231 DEBUG command-line options: <access_key>: AKIAILA5HGSTJGH4W3QQ
2017-01-11 14:30:42,231 DEBUG command-line options: --help: False
2017-01-11 14:30:42,240 DEBUG Role ARN provided. Attempting to assume role
```


### Notes

 - The default STS token validity is one hour (3600 seconds) and is currently set by AWS

