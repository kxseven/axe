# axe-scp

Used as a helper utility to wrap the default SCP tool. The tool attempts to map a given target name to an available instance, in turn attempting to map that to an accessable Public or Private IP address

## Command

    $ axe scp -h
    usage: axe-scp <target>:<path> <path> [options]
           axe-scp ( -h | --help )


## Example Usage

    $ axe scp user@chef.dev.customer.com:/var/log/syslog ~/Downloads/syslog.txt
    2015-09-09_18:12:50,055 INFO  Attempting to resolve target chef.dev.customer.com
    2015-09-09_18:12:51,060 INFO  Discovered only a Private IP
    2015-09-09_18:12:51,100 INFO  Attempting connection to 10.123.45.67

## Notes

 - Additional options can be passed to the `axe scp` tool as long as they are compatible with the SCP client itself


