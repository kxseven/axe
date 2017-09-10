# Troubleshooting

Some of the most common issues when using the AXE tools are detailed here. Please submit an Issue or a PR if you find something that needs revision.

## Boto NoAuthHandlerFound

!!! bug "Problem Description"
    Loading Identity fails due to `boto.exception.NoAuthHandlerFound`

**Error Message**

```
boto.exception.NoAuthHandlerFound: No handler was ready to authenticate.
  1 handlers were checked. ['HmacAuthV4Handler'] Check your credentials
ERROR: Valid credentials not found in /tmp/awsmfaCUR8. Token generation failed
```

**Solution**

 - Run `aws configure` at least once and give it some dummy information so that it will create `~/.aws/credentials`. You can use any values here as they won't be used by the AXE tools


## Subsequent commands fail after first failure

!!! bug "Problem Description"
    After the first AXE command fails, repeated attempts of the same command also fail for up to five minutes after the first failure

 - Several of the AXE subcommands use API calls that can either (1) take several seconds to process or (2) generate a large amount of data in response.
 - In order to mitigate both of these a script helper called `cache` is used that attempts to buffer the response of a given AXE command for up to five minutes before allowing the command to reach the AWS API again.
 - This can be useful when re-querying the same data that generates a large response (describe instances) but can generate multiple failures if the first attempt fails (no creds loaded, etc).

**Solution**

 - You can remove the temporary buffer that the `cache` command created with `rm -Rf /tmp/axecache`
 - You can wait 5 minutes
