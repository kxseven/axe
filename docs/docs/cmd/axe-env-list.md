# axe-env-list

Used to list the available environment stacks found within a given stack base directory (cb-root)

## Command

    $ axe env-list -h
    Used to list the available environment stacks found within a given stack base
    directory (cb-root).

    Usage:
        axe-env-list [options]
        axe-env-list ( -h | --help )

    Options:
        -c <cb-root>, --cb-root=<cb-root>
                             The $CLOUDBUILDER_ROOT defaults to ~/.cloudbuilder but
                             can be overridden if required. [default: ~/.cloudbuilder]
        -f <format>, --format=<format>
                             Supported values are; plain, simple, grid, pipe,
                             orgtbl, rst, mediawiki, latex [default: simple]
        -h, --help           Show this help message and exit
        --debug              Show more verbose logging

## Example Usage

    $ axe env-list
    Stack Name     Relative Path      Config    Template    Auth    SG-Aliases    SG-Groups    SG-Rules    Instances    ELB
    -------------  -----------------  --------  ----------  ------  ------------  -----------  ----------  -----------  -----
    BOSS-DEV       version1/boss/dev  Yes       No          Yes     Yes           Yes          Yes         Yes          No
    BOSS-RED       version1/boss/red  Yes       Yes         Yes     Yes           Yes          Yes         Yes          No
    EXAMPLE_STACK  example            Yes       No          Yes     No            No           No          No           No


## Notes

 - The tool also attempts to determine how complete a discovered environment configuration is by displaying which of the key stack configuration files it has found
 - The tool can also be invoked with `-f pipe` to generate Markdown output for easy documentation

| Stack Name    | Relative Path     | Config   | Template   | Auth   | SG-Aliases   | SG-Groups   | SG-Rules   | Instances   | ELB   |
|:--------------|:------------------|:---------|:-----------|:-------|:-------------|:------------|:-----------|:------------|:------|
| BOSS-DEV      | version1/boss/dev | Yes      | No         | Yes    | Yes          | Yes         | Yes        | Yes         | No    |
| BOSS-RED      | version1/boss/red | Yes      | Yes        | Yes    | Yes          | Yes         | Yes        | Yes         | No    |
| EXAMPLE_STACK | example           | Yes      | No         | Yes    | No           | No          | No         | No          | No    |
