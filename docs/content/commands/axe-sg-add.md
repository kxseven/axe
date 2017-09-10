
## sg-add

Associates designated SecurityGroups with instances with support for filtering based on Tags or VPCs

### Command

```
Basic script to add the specified SG to an instance if the matching SG is
found currently associated

Usage:
    axe-sg-add -g <sg-id> [options]
    axe-sg-add ( -h | --help )

Options:
    -s <sg-filter>, --sg-filter=<sg-id>
                         Only action on instances that already have this SG
                         associated with them
    -t <tag-filter>, --tag-filter=<tag-name>
                         Only action on instances that already have this Tag
                         key-pair associated with them. Use a format of
                         "KeyName|KeyValue" and remember the data is
                         case-sensitive
    -v <vpc-filter>, --vpc-filter=<vpc-id>
                         Only action on instances that are contained within the
                         specified VPC
    -g <sg-id>, --sg-id=sg-id
                         The new SecurityGroup ID to add to the instance
    -y, --yes            Required to actually do anything. Otherwise it just
                         lists what would have been affected [default: False]
    -h, --help           Show this help message and exit
    --debug              Show more verbose logging
```

### Example Usage

**Simple**
```
$ axe sg-add --sg-id sg-bdb61ddb -vpc-filter vpc-08ef6kh7 --tag-filter "Unit|Finance"
2016-12-15 09:17:51,470 INFO   Discovered 237 EC2 instances
2016-12-15 09:17:51,470 INFO   Applying filter by searching for matching VPC vpc-08ef6kh7 association
2016-12-15 09:17:51,471 INFO   After filtering by VPC we now have 123 instances
2016-12-15 09:17:51,471 INFO   Applying filter by searching for matching SG sg-348f1334 association
2016-12-15 09:17:51,471 INFO   After filtering by SG we now have 85 instances
2016-12-15 09:17:51,471 INFO   Applying filter by searching for Tag name [Unit] with value [Finance]
2016-12-15 09:17:51,472 INFO   After filtering by Tags we now have 85 instances
2016-12-15 09:17:51,472 INFO   Applying filter by searching matching SG sg-bdb61ddb association already existing
2016-12-15 09:17:51,472 INFO   After filtering by existing SG we now have 0 instances
```

### Notes

 - A set of valid AWS credentials must be loaded for this to work
 - No changes are actually made until the `-y` flag is provided

