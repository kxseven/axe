# axeutils

The axeutils library is a collection of code snippets I found myself needing over and over again when creating individual AXE sub-commands.


## axeutils.config

The config helper is designed to help load text based configuration files, returning a dictionary of objects for use with your function/application

The `get_config_from_file` function will attempt to use the file extension to determine the parser needed unless provided by the calling 'fmt' argument

Currently has summport for the following formats; INI, Markdown tables, YAML

### Using the logger in an axe-command

 - Import the config wrapper in an `axe-<command>`

    ``` python
    from axeutils.config import get_config_from_file
    params = get_config_from_file(params_filename)
    # -or-
    params = get_config_from_file(params_filename, fmt='ini')
    ```

### Using the logger in an AXE lib module/submodule

 - Import the config wrapper in an `axe-<command>`

    ``` python
    from axeutils.config import get_config_from_file
    params = get_config_from_file(params_filename)
    # -or-
    params = get_config_from_file(params_filename, fmt='ini')
    ```


## axeutils.logger

The logging helper is designed so that all logging triggered will be passed to at least two handlers and output in a consistent format

 - Console output to stderr
 - File output with a name corresponding to the name of the `axe-command` in the `$AXE_ROOT/log` dir

### Using the logger in an axe-command

 - Import the logging wrapper, common import checker and clean-up hook in an `axe-<command>`

    ``` python
    from axeutils.logger import AxeLog
    from axeutils import check_imports, clean_up
    ```

 - Initialise logging and ensure common imports are available

    ``` python
    _log = AxeLog(__file__)
    check_imports()
    ```

 - Changing the logging level if '--debug' is specified

    ``` python
    if options['--debug'] is True:
        import logging
        _log.setLevel(logging.DEBUG)

    for key, value in options.iteritems():
        _log.debug('command-line options: {}: {}'.format(key, value))
    ```

 - Using logging once setup

    ``` python
    _log.info('message')_
    ```

### Using the logger in an AXE lib module/submodule

 - Import the log wrapper, default context and clean-up hook

    ``` python
    import logging
    from axeutils.logger import LOG_CONTEXT
    from axeutils import clean_up, CONST_AXE_ROOT
    ```

 - Initialise logging

    ``` python
    _log = logging.getLogger(LOG_CONTEXT)
    ```

 - Using logging once setup

    ``` python
    _log.info('message')_
    ```

