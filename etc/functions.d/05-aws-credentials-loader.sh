# A simple function to load and export the AWS credentials from a given file.
# We expect the credentials to be in standard AWS-Conf format;
#
#   aws_access_key_id=ASDFGHJKDFGHJGH
#   aws_secret_access_key=DFGBNM&UYJFGHJ&UJ&*(*I%TG)
#
#   ..which we will export into two environment variables AWS_ACCESS_KEY_ID
#   and AWS_SECRET_ACCESS_KEY
#

# Default MFA token duration in seconds
DEFAULT_TOKEN_DURATION=14400

_chomp() {
    local s="$(echo "${@}" | sed -e 's/^ *//g;s/ *$//g')"
    echo "${s}"
}


# Helper function to load simple API keys
_load_basic_credentials() {

    # Load the INI config and make it available for use
    _ini_cfg_parser "${1}"
    cfg.section.default

    AWS_DEFAULT_REGION="${region}"
    AWS_ACCESS_KEY_ID="${aws_access_key_id}"
    AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}"

    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION

}


_load_credentials_from_json() {

    AWS_CONFIG_FILE=$(mktemp /tmp/awsmfaXXXX)

    jq '.Credentials | {
        AWS_ACCESS_KEY_ID: (.AccessKeyId),
        AWS_SECRET_ACCESS_KEY: (.SecretAccessKey),
        AWS_SESSION_TOKEN: ((.SessionToken) // ""),
        AWS_SECURITY_TOKEN: ((.SessionToken) // ""),
        AWS_EXPIRY: ((.Expiration) // "")
        }' "${1}" \
        | json2properties > ${AWS_CONFIG_FILE}

    . ${AWS_CONFIG_FILE}

    # Now set the token expiry time so that it can be used for the PS1 prompt
    let AWS_TOKEN_EXPIRY=$(date +"%s" --date "${AWS_EXPIRY}")
    local expiry_time=$(date +"%Y-%m-%d %H:%M:%S" --date @${AWS_TOKEN_EXPIRY})
    echo -e "INFO : ${__fg_yellow}AWS_TOKEN_EXPIRES......${__no_color} $expiry_time"

    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION
    export AWS_SECURITY_TOKEN AWS_TOKEN_EXPIRY AWS_SESSION_TOKEN

}


# Helper function to get API keys using MFA token
_load_mfaauth_credentials() {

    # Load the INI config and make it available for use
    _ini_cfg_parser "${1}"
    cfg.section.default

    AWS_DEFAULT_REGION="${region}"
    AWS_ACCESS_KEY_ID="${aws_access_key_id}"
    AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}"
    AWS_MFA_ID="${aws_mfa_id}"

    AWS_CONFIG_FILE=$(mktemp /tmp/awsmfaXXXX)

    echo -e -n "INFO : ${__fg_red}MFA Account Detected... ${__no_color}"
    read -p "Please specify the MFA PIN Now: " response
    ${PROJECT_ROOT}/bin/subcommands/axe-token-mfaauth-create \
        "$aws_access_key_id" \
        "$aws_secret_access_key" \
        "$AWS_MFA_ID" \
        "$response" \
        > $AWS_CONFIG_FILE

    AWS_ACCESS_KEY_ID="$(grep -h aws_access_key_id "$AWS_CONFIG_FILE" | awk '{print $2}')"
    AWS_SECRET_ACCESS_KEY="$(grep -h aws_secret_access_key "$AWS_CONFIG_FILE" | awk '{print $2}')"
    AWS_SECURITY_TOKEN="$(grep -h -i aws_security_token "$AWS_CONFIG_FILE" | awk '{print $2}')"
    AWS_SESSION_TOKEN="$(grep -h -i aws_security_token "$AWS_CONFIG_FILE" | awk '{print $2}')"

    echo -e "INFO : ${__fg_yellow}AWS_MFA_ID.............${__no_color} $AWS_MFA_ID"

    # Now set the token expiry time so that it can be used for the PS1 prompt
    let AWS_TOKEN_EXPIRY=$(date +"%s")+$DEFAULT_TOKEN_DURATION
    local expiry_time=$(date +"%Y-%m-%d %H:%M:%S" --date @${AWS_TOKEN_EXPIRY})
    echo -e "INFO : ${__fg_yellow}AWS_TOKEN_EXPIRES......${__no_color} $expiry_time"

    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION
    export AWS_MFA_ID AWS_SECURITY_TOKEN AWS_TOKEN_EXPIRY AWS_SESSION_TOKEN

}


# Helper function to get API keys using ADFS based SAML2 authentication to AWS
# after IDP form based login
_load_krb5formauth_credentials() {

    # Load the INI config and make it available for use
    _ini_cfg_parser "${1}"
    cfg.section.default

    AWS_DEFAULT_REGION="${region}"
    AWS_ACCESS_KEY_ID="${aws_access_key_id}"
    AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}"

    AWS_CONFIG_FILE=$(mktemp /tmp/awsmfaXXXX)

    # Only attempt Kerberos based token generation if we have a valid kerberos
    # token at present
    active_tokens="$(klist 2>/dev/null)"
    [ $? -eq 0 ] || { echo "ERROR: I can't protect from your own stupidity. No Kerberos token found. Start with kinit" && return ;}

    echo -e "INFO : ${__fg_red}Kerberos IDP Account Detected... ${__no_color}"
    ${PROJECT_ROOT}/bin/subcommands/axe-token-krb5formauth-create \
        "${region}" \
        "${aws_idp_url}" \
        "${identity_path}/idp_params.json" \
        "${aws_idp_principal}" \
        "${AWS_CONFIG_FILE}" \
        "${DEFAULT_TOKEN_DURATION}"

    [ $? -eq 0 ] || { echo "ERROR: IDP Token generation failed" && return ;}

    AWS_ACCESS_KEY_ID="$(grep -h aws_access_key_id "$AWS_CONFIG_FILE" | awk '{print $2}')"
    AWS_SECRET_ACCESS_KEY="$(grep -h aws_secret_access_key "$AWS_CONFIG_FILE" | awk '{print $2}')"
    AWS_SECURITY_TOKEN="$(grep -h -i aws_session_token "$AWS_CONFIG_FILE" | awk '{print $2}')"
    AWS_SESSION_TOKEN="$(grep -h -i aws_session_token "$AWS_CONFIG_FILE" | awk '{print $2}')"

    # Now set the token expiry time so that it can be used for the PS1 prompt
    let AWS_TOKEN_EXPIRY=$(date +"%s")+$DEFAULT_TOKEN_DURATION
    local expiry_time=$(date +"%Y-%m-%d %H:%M:%S" --date @${AWS_TOKEN_EXPIRY})
    echo -e "INFO : ${__fg_yellow}AWS_TOKEN_EXPIRES......${__no_color} $expiry_time"

    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION
    export AWS_SECURITY_TOKEN AWS_SESSION_TOKEN AWS_TOKEN_EXPIRY

}


load_aws_credentials() {

    # Unset any AWS_ env variables
    local aws_vars="$(env | grep '^AWS_')"
    for item in $aws_vars; do
        var_name="$(echo "${item}" | awk -F'=' '{print $1}')"
        unset $var_name
    done

    unset region
    unset aws_mfa
    unset aws_session_token
    unset aws_security_token
    unset aws_secret_access_key
    unset aws_idp_url
    unset aws_idp_principal

    # Clear function definitions
    funcs="$(declare -F | grep 'cfg\.')"
    funcs="${funcs//declare -f/}"
    for f in $funcs; do
        unset -f "$f"
    done

    # Create a list of identities as well as a corresponding list of identity names
    local personal_id_names="$(find -L ~/.axe/identities/* -maxdepth 1 -type d -print 2> /dev/null | _xargs basename)"
    local project_id_names="$(find -L ~/.cloudbuilder/identities/* -maxdepth 1 -type d -print 2> /dev/null | _xargs basename)"
    local vs_id_names="${personal_id_names} ${project_id_names}"
    local vs_ids="$(find -L ~/.axe/identities/* -maxdepth 1 -type d -print 2> /dev/null) $(find ~/.cloudbuilder/identities/* -maxdepth 1 -type d -print 2> /dev/null)"
    local options=( $vs_id_names )
    local real_paths=( $vs_ids )

    # Ensure we have at least one identity to offer before proceeding
    if [ ! ${#options[@]} -ge 1 ]; then
        _log "$LINENO" "No identities currently configured. RTFM."
        return 1
    fi

    _print_head_l1 "Available Identities"

    profile_idx=1
    local VS_BADGES=()
    # Build Personal Identities
    for next_id in $personal_id_names; do
        VS_BADGES+=("$(printf '%b%3.3s%b : %s' "${__fg_yellow}" "${profile_idx}" "${__no_color}" "${next_id}")")
        let profile_idx=profile_idx+1
    done
    # Build Project Identities
    for next_id in $project_id_names; do
        VS_BADGES+=("$(printf '%b%3.3s%b : %s' "${__fg_cyan}" "${profile_idx}" "${__no_color}" "${next_id}")")
        let profile_idx=profile_idx+1
    done

    # Find the length of the longest entry
    col_width=$(printf '%s\n' "${VS_BADGES[@]}" | awk '{ print length(), $0 | "sort -n" }' | tail -1 | awk '{print $1}')
    badge_template="%-${col_width}.${col_width}s\\n"
    printf $badge_template "${VS_BADGES[@]}" | column

    echo
    read -p "Please select an identity: " REPLY

    let idx=$REPLY-1
    local identity_path="${real_paths[idx]}"
    local identity="$(basename $identity_path)"

    identity_path="$(_chomp "$identity_path")"

    AWS_SSH_KEY="${identity_path}/ssh_id.pem"
    AWS_CONFIG_FILE="${identity_path}/aws.conf"
    AWS_ID_NAME="${identity}"

    # Ensure the files we need actually exist
    [ ! -f $AWS_SSH_KEY ] && echo "ERROR: No PrivateKey file found $AWS_SSH_KEY" && return
    [ ! -f $AWS_CONFIG_FILE ] && echo "ERROR: No credentials file found $AWS_CONFIG_FILE" && return

    if grep -q "aws_mfa" "$AWS_CONFIG_FILE"; then
        # Check if we have MFA to process
        _load_mfaauth_credentials "${AWS_CONFIG_FILE}"
    elif grep -q "aws_idp" "$AWS_CONFIG_FILE"; then
        # Check if we have IDP to process
        _load_krb5formauth_credentials "${AWS_CONFIG_FILE}"
    else
        # If we haven't matched one of the earlier patterns
        _load_basic_credentials "${AWS_CONFIG_FILE}"
    fi

    # Check to determine if we have a valid set of credentials for use
    { [ -z $AWS_ACCESS_KEY_ID ] || [ -z $AWS_SECRET_ACCESS_KEY ]; } && { echo "ERROR: Valid credentials not found in $AWS_CONFIG_FILE. Token generation failed" && return;}

    echo -e "INFO : ${__fg_yellow}AWS_CONFIG_FILE........${__no_color} $AWS_CONFIG_FILE"
    echo -e "INFO : ${__fg_yellow}AWS_SSH_KEY............${__no_color} $AWS_SSH_KEY"
    echo -e "INFO : ${__fg_yellow}AWS_DEFAULT_REGION.....${__no_color} $AWS_DEFAULT_REGION"
    echo -e "INFO : ${__fg_yellow}AWS_ACCESS_KEY_ID......${__no_color} $AWS_ACCESS_KEY_ID"
    echo -e "INFO : ${__fg_yellow}AWS_SECRET_ACCESS_KEY..${__no_color} $AWS_SECRET_ACCESS_KEY"

    export AWS_SSH_KEY AWS_ID_NAME
    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION
    export AWS_SECURITY_TOKEN AWS_SESSION_TOKEN AWS_TOKEN_EXPIRY

    # We now need to unset AWS_CONFIG_FILE to ensure that it's the AWS API
    # variables that are detected and used
    unset AWS_CONFIG_FILE

}
