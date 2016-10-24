# axeutils.config

The config helper is designed to help load text based configuration files, returning a dictionary of objects for use with your function/application

The `get_config_from_file` function will attempt to use the file extension to determine the parser needed unless provided by the calling 'fmt' argument

Currently has summport for the following formats; INI, MarkDown tables, YAML

## Using the logger in an axe-command

 - Import the config wrapper in an `axe-<command>`

        from axeutils.config import get_config_from_file
        params = get_config_from_file(params_filename)
         -or-
        params = get_config_from_file(params_filename, fmt='ini')

## Using the logger in an AXE lib module/submodule

 - Import the config wrapper in an `axe-<command>`

        from axeutils.config import get_config_from_file
        params = get_config_from_file(params_filename)
         -or-
        params = get_config_from_file(params_filename, fmt='ini')
