
## subnet-claim-ip

Detect available IP addresses from subnet by temporarily claiming one or more IPs and then releasing again. This can be useful when pre-provisioning static DNS entries and needing to assign static DHCP leases from the VPC.

### Command

```
usage: axe-subnet-claim-ip [--help] [-s <SUBNET-ID>] [num-ips]

Simple utility script to claim and then release available Private IP addresses
from the specified subnet-id by allocating and then deleting an ENI in the same
subnet

Useful if you need to determine which Private VPC adddresses can be used as
reserved DHCP allocations (aka static private VPC IP on AWS)
```

### Example Usage

**Simple**
```
$ axe subnet-claim-ip -s 947fcjhd
[2017-10-04T14:32:31+0100]: axe-subnet-claim-ip:0102 : Requesting IP in subnet subnet-947fcjhd
[2017-10-04T14:32:32+0100]: axe-subnet-claim-ip:0111 : Detected IP allocation: 10.243.166.116 from eni-ffb164a1
[2017-10-04T14:32:32+0100]: axe-subnet-claim-ip:0114 : Releasing ENI and IP
[2017-10-04T14:32:33+0100]: axe-subnet-claim-ip:0117 : Done. Result Code 0
```

### Notes

 - A set of valid AWS credentials must be loaded for this to work

