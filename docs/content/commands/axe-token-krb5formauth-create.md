
## token-krb5formauth-create

Attempts to get valid AWS session credentials using available SAML2 assertions after authenticating against a specified IDP hosted form that requires Kerberos based authentication (common in corporate/enterprise environments with federated login)

!!! warning "Internal but useful for troubleshooting"
    This AXE command is used internally to load identity profiles which are then used to request API access. Generally only useful when troubleshooting issues with IDP

### Command

```
Basic script to provide AWS Session Tokens using Kerberos token in combination
with a form based IDP service/portal to generate valid SAML2 Response that can
be used for AWS API services

This script only works once Kerberos auth is correctly configured on the local
workstation. You can test this with
    'kinit user@REALM' - Attempt to auth
    'klist'            - List existing Kerberos tokens

Usage:
    axe-token-krb5formauth-create <aws_region> <saml_idp_url> <idp_params> <principal> <creds_file> [<token_duration>] [ options ]
    axe-token-krb5formauth-create ( -h | --help )

Arguments:
  aws_region        The AWS Region to auth against
  idp_params        A JSON dictionary of parameters that are needed for form
                    based authentication. A value of '<ask>' can be used to
                    trigger reading the value at runtime from the user. A value
                    of '<password>' can be used to trigger reading the value at
                    runtime securely
  saml_idp_url      The IDP/SAML URL that is used to trigger authentication
  principal         The identity to authenticate with in the form of user@REALM
  creds_file        The filename to store credentials in if successful
  token_duration    The duration in seconds that a requested token is valid for
                    from the time of successful authentication [default: 3600]

Options:
  --sslverify       Whether or not to validate the SSL cert from the SAML URL.
                    Generally not recommended for URLs using self-signed
                    certificates
  --debug           More verbose (usually debug) logging and output
```

### Example Usage

**Simple**
```
$ axe token-krb5formauth-create eu-west-1 'https://internal-idp-portal.company.org/idp/' idp_params.json
2016-07-08 16:04:40,143 DEBUG  command-line options: <saml_idp_url>: https://internal-idp-portal.company.org/idp/startSSO.ping?PartnerSpId=urn:amazon:webservices
2016-07-08 16:04:40,143 DEBUG  command-line options: <principal>: DUMMYUSER1@COMPANY.ORG
2016-07-08 16:04:40,143 DEBUG  command-line options: <idp_params>: idp_params.json
2016-07-08 16:04:40,144 DEBUG  Loaded payload: {u'form.pass': u'<password>', u'form.ok': u'clicked', u'form.username': u'DUMMYUSER1'}
2016-07-08 16:04:43,611 DEBUG  Building HTTP session
2016-07-08 16:04:45,967 DEBUG  Posting payload to https://internal-idp-portal.company.org/idp/QHWYR/resumeSAML20/idp/startSSO.ping
2016-07-08 16:04:46,133 DEBUG  Found SAMLResponse
2016-07-08 16:04:46,158 DEBUG  Allocated AWS Roles
```

### Notes

 - If successful a list of available AWS IAM Roles will be provided from which the user must then select to activate

