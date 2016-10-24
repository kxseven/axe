# Intended to perform all tasks that need to be executed on a first run of the
# tools

# Create a tmp dir if none exists
if [ ! -d "${PROJECT_ROOT}/tmp" ]; then
    mkdir -p "${PROJECT_ROOT}/tmp"
fi

# Create a log dir if none exists
if [ ! -d "${PROJECT_ROOT}/log" ]; then
    mkdir -p "${PROJECT_ROOT}/log"
fi

# Create an user identities dir if none exists
if [ ! -d ~/.axe/identities ]; then
    mkdir -p ~/.axe/identities
fi
