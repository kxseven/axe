# AXE: Cloud Hatchet

[![GitHub license](https://img.shields.io/github/license/kxseven/axe.svg?style=flat-square)](https://github.com/kxseven/axe/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/kxseven/axe.svg?style=flat-square)](https://github.com/kxseven/axe/releases)
[![GitHub changelog](https://img.shields.io/badge/docs-CHANGELOG-orange.svg?style=flat-square)](http://awsaxe.readthedocs.io/en/latest/content/about/release-notes/)
[![Docker Pulls](https://img.shields.io/docker/pulls/kxseven/axe.svg)](https://hub.docker.com/r/kxseven/axe)

## What is AXE and how can it help me?

The AXE tools are a collection of Python and BASH helper scripts that are intended to augment your existing interaction with AWS by;

- Helping with the loading of AWS credentials into the environment that can be re-used by all of your existing AWS toolset; Terraform, AWS CLI, Terraforming, Ansible, etc
- Helping to generate useful information about existing resources you already have on AWS in a format that can be used as part of a pipeline for other tools/apps

---

 - View the [AXE Documentation]

[AXE Documentation]: http://awsaxe.readthedocs.io/


## Docker by default

The preferred method of installing and using AXE is now a Docker container based version that brings you all that you need to run and use AXE without disrupting your normal OS package setup.

This should make it easier for you to use the latest version and make it easier to rollback an update if a new version breaks something you relied on


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
        kxseven/axe:latest
    ```
