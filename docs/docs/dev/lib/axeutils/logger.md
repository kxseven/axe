# axeutils.logger

The logging helper is designed so that all logging triggered will be passed to at least two handlers and output in a consistent format

 - Console output to stderr
 - File output with a name corresponding to the name of the `axe-command` in the `$AXE_ROOT/log` dir

## Using the logger in an axe-command

 - Import the logging wrapper, common import checker and clean-up hook in an `axe-<command>`

        from axeutils.logger import AxeLog
        from axeutils import check_imports, clean_up

 - Initialise logging and ensure common imports are available

        _log = AxeLog(__file__)
        check_imports()        

 - Changing the logging level if '--debug' is specified

        if options['--debug'] is True:
            import logging
            _log.setLevel(logging.DEBUG)

        for key, value in options.iteritems():
            _log.debug('command-line options: {}: {}'.format(key, value))

 - Using logging once setup

        _log.info('message')_

## Using the logger in an AXE lib module/submodule

 - Import the log wrapper, default context and clean-up hook

        import logging
        from axeutils.logger import LOG_CONTEXT
        from axeutils import clean_up, CONST_AXE_ROOT

 - Initialise logging

        _log = logging.getLogger(LOG_CONTEXT) 

 - Using logging once setup

        _log.info('message')_
