# axe-auth-token-create

Used to create a Multi-Factor-Authentication token containing valid credentials for cloud API access.

## Command

    Usage:
        axe-auth-token-create <access_key> <secret_key> <mfa_serial_number> <mfa_token> [ --debug ]
        axe-auth-token-create ( -h | --help )

## Example Usage

This subcommand is not used directly but is used by other tools to interact with the user if an AXE Identity is being loaded that requires MFA

    axe auth-token-create $aws_user_id $aws_user_secret $aws_mfa_id $mfa_token_code

## Notes



