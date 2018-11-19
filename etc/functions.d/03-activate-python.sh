# Activate the local instance of Python or correct the PYTHONPATH env variable
# depending on the OS detected.
# TODO(kxseven: Better solution needed on OSX for forked shells from within Python
if [[ "$(uname)" == "Darwin" ]]; then
   export PYTHONPATH="${AXE_ROOT}/local/python/lib/python2.7/site-packages:${AXE_ROOT}/lib:${AXE_ROOT}/bin/tools:${AXE_ROOT}/bin/subcommands"
elif [[ "${AXE_CONTAINER}" == "docker" ]]; then
       PYTHONPATH=$PYTHONPATH:${AXE_ROOT}/lib/python:${AXE_ROOT}/bin/tools:${AXE_ROOT}/bin/subcommands
       export PYTHONPATH
else
    if [ -e "${AXE_ROOT}/local/python/bin/activate" ]; then
       source ${AXE_ROOT}/local/python/bin/activate
       PYTHONPATH=$PYTHONPATH:${AXE_ROOT}/lib/python:${AXE_ROOT}/bin/tools:${AXE_ROOT}/bin/subcommands
       export PYTHONPATH
    else
        _log "$LINENO" "The Python VirtualEnv does not appear to be present where I expect it to be: ${AXE_ROOT}/local/python"
    fi
fi
