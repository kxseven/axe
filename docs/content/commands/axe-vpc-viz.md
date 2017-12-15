
## vpc-viz

Creates a simple visualization in one or more output formats to represent VPC resources. Defaults to creating a visualization per VPC if a specific VPC-id is not provided (see usage below)

!!! tip "GraphViz Installed?"
    If a valid Graphviz installation is detected then automatic conversion to other output formats can be performed. This will be visible when specifying the `-x` or `--extra` flags
    ```
    14:54:42 0065 INFO  Graphviz install detected.
    14:54:46 0065 INFO  Created workspace/output/aws-vpc-1a2b3c4d.png
    14:54:46 0065 INFO  Created workspace/output/aws-vpc-1a2b3c4d.svg
    ```
    See [Installing](/content/user-guide/installing/) for more info

### Command

```
Usage:
    axe-vpc-viz [options]
    axe-vpc-viz ( -h | --help )

Options:
    -v <vpc-id>, --vpc-id=<vpc-id>
                        Dump resources in the matching only VPC. Defaults to
                        creating one output per VPC discovered
    -o <output-dir>, --output=<output-dir>
                        Directory in which to output any resource created.
                        Defaults to the current directory [default: .]
    -f <output-format>, --format=<output-format>
                        Supported formats are; dot [default: dot]
    -d <dir>, --dir=<dir>
                        Graphviz graph direction. Only used for gviz output
                        Can be one of; BT, TB, RL, LR [default: TB]
    -x, --extra         Attempt GraphViz package detection and if found create
                        additional PNG and SVG outputs
    --no-ec2            Hide EC2 resources
    --no-routing        Hide VPC Routing resources (RouteTable)
    --no-cx             Hide private connection resources (DX, VPN, Peering)
    --debug             Show more verbose logging

Graphviz diagrams can be converted to images if you also have the 'dot'
packages installed. If the 'dot' command is available from the $PATH then
automatic conversion will be attempted

  PNG:  dot -Tpng aws-vpc-1234567.dot -o aws-vpc-1234567.png
  SVG:  dot -Tsvg aws-vpc-1234567.dot -o aws-vpc-1234567.svg
```

 - The list of available output types is compiled from all files matching directory names of Jinja2 templates in `$AXE_ROOT/etc/visual.d/templates/`

### Example Usage

**Visualize a single VPC and generate PNG and SVG outputs into `output` directory**
```
axe vpc-viz -v vpc-1a2b3c4d -x -o output
```

**Visualize all VPCs into current directory**
```
axe vpc-viz
```


### Notes

 - A set of valid AWS credentials must be loaded for this to work


