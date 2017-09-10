
## axe-dump-account

Dumps all possible AWS resources to Terraform that are supported by the [terraforming] tool

[terraforming]: https://github.com/dtan4/terraforming

### Command
```
usage: axe-dump-account [--help] [-d <DIR>]

Attempts to dump all of the AWS account in Terraform format to the specified
directory (defaults to current working directory). A sub-directory is created
for each available AWS region.

It is normal for errors to be generated during a run if a specific resource
is not supported in that region or if permissions for specific resources are
unavailable to the API user performing the dump

This wrapper script relies on the Terraforming tool available from
https://github.com/dtan4/terraforming and will not function without it.
```


### Example Usage

```
$ axe dump-account
[2017-09-07T20:49:22+0100]: 141 : INFO  Checking for terraforming support
[2017-09-07T20:49:22+0100]: 148 : INFO  Ensuring target path exists
[2017-09-07T20:49:22+0100]: 091 : INFO  Generate an initial tfstate
[2017-09-07T20:49:23+0100]: 094 : INFO  Dumping the state for each global resource type
[2017-09-07T20:49:23+0100]: 096 : INFO  Dumping iamg
[2017-09-07T20:49:24+0100]: 096 : INFO  Dumping iamgm
[2017-09-07T20:49:26+0100]: 096 : INFO  Dumping iamgp
[2017-09-07T20:49:28+0100]: 096 : INFO  Dumping iamip
[2017-09-07T20:49:29+0100]: 096 : INFO  Dumping iamp
[2017-09-07T20:49:31+0100]: 096 : INFO  Dumping iampa
[2017-09-07T20:49:33+0100]: 096 : INFO  Dumping iamr
[2017-09-07T20:49:34+0100]: 096 : INFO  Dumping iamrp
[2017-09-07T20:49:36+0100]: 096 : INFO  Dumping iamu
[2017-09-07T20:49:37+0100]: 096 : INFO  Dumping iamup
[2017-09-07T20:49:40+0100]: 096 : INFO  Dumping r53r
[2017-09-07T20:49:41+0100]: 096 : INFO  Dumping r53z
[2017-09-07T20:49:43+0100]: 163 : INFO  Spawning background process regional resources for ap-south-1
[2017-09-07T20:49:43+0100]: 163 : INFO  Spawning background process regional resources for eu-west-2
[2017-09-07T20:49:43+0100]: 163 : INFO  Spawning background process regional resources for eu-west-1
[2017-09-07T20:49:43+0100]: 163 : INFO  Spawning background process regional resources for ap-northeast-2
[2017-09-07T20:49:43+0100]: 163 : INFO  Spawning background process regional resources for ap-northeast-1
<snip>
```

Once complete a directory will be created for each support AWS region, containing all the Terraform for each AWS region as well as a `terraform.tfstate` file

```
$ ls
ap-northeast-1
ap-northeast-2
ap-south-1
ap-southeast-1
ap-southeast-2
ca-central-1
eu-central-1
eu-west-1
eu-west-2
global
sa-east-1
us-east-1
us-east-2
us-west-1
us-west-2
```

### Notes

 - A set of valid AWS credentials must be loaded for this to work
 - A full dump of all regions can take up to 30 minutes so ensure your STS Token is refreshed before starting

