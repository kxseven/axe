# Get AXE

The preferred method of installing and using AXE is now a Docker container based version that brings you all that you need to run and use AXE without disrupting your normal OS package setup.

This should make it easier for you to use the latest version and make it easier to rollback an update if a new version breaks something you relied on

## Before you start

!!! tip "Local install still available"
    - You can use the local installed version of AXE if you prefer to run without Docker. Use the [Local Install of AXE](/content/user-guide/installing/) guide instead if you are unable or prefer the non-docker based setup.


## Get and Use AXE

- From your command line pull the latest AXE image

    ```console
    $ docker pull kxseven/axe:latest
    ```

- Run the AXE container, passing in your AXE identities

    ```console
    $ docker run \
        -it \
        --network=host \
        -v ${HOME}/.axe:/home/axe/.axe \
        axe:latest
    ```

