####################################################################################
#
# AXE Container
#
###############################################################################
#
# FROM section
#
FROM alpine:3.7
MAINTAINER kxseven

###############################################################################
#
# ENV - Environment variables section
# Set variables and locales
#
###############################################################################
ENV AXE_ROOT /opt/axe
ENV PYTHONPATH /opt/axe/lib/python
ENV PATH /opt/axe/bin:/opt/axe/bin/tools:$PATH
ENV AXE_PYTHON_DEPS /opt/axe/requirements/requirements.python2
ENV AXE_CONTAINER docker
ENV PATCHED_FONT_IN_USE yes
ENV AXE_VERSION_DOCKER latest

ENV RUNTIME_PACKAGES \
  bash \
  coreutils \
  curl \
  tar \
  openssh-client \
  sshpass \
  git \
  python \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-jinja2 \
  py-paramiko \
  py-pip \
  py-yaml \
  ncurses \
  util-linux \
  util-linux-bash-completion \
  jq \
  ca-certificates


###############################################################################
#
# ARG - Arguments section
# Set arguments on build
#
###############################################################################


###############################################################################
#
# LABEL section - default labels
# Basic build-time metadata as defined at http://label-schema.org
#
###############################################################################

###############################################################################
#
# Setup any volumes needed for persistant storage
#
###############################################################################
#VOLUME ${DATADIR}
#VOLUME ${CONFDIR}

###############################################################################
#
# ACTIONS section: for COPY and RUN commands
#
# Install any dependancies using '&&' to combine commands that should be in the
# same 'layer' in order to minimise the number of tasks that actually need to
# be run on subsequent builds
#
###############################################################################

# Add our dummy user and group
RUN adduser -D -u 1000 axe

RUN mkdir -p /opt/axe
COPY / /opt/axe

RUN \
    apk --update add --virtual build-dependencies \
    alpine-sdk \
    gcc \
    krb5-dev \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python-dev \
    && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    pip install -r ${AXE_PYTHON_DEPS} --disable-pip-version-check && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /opt/axe/log /opt/axe/tmp /home/axe/.aws

RUN echo '. /opt/axe/etc/axerc' >> /home/axe/.bashrc

RUN echo '[default]' >> /home/axe/.aws/config
RUN echo 'output = json' >> /home/axe/.aws/config


RUN chown -R axe: /opt/axe
RUN chown -R axe: /home/axe

USER axe

###############################################################################
#
# CMD section:
# run the application
#

WORKDIR /home/axe

ENTRYPOINT ["/bin/bash"]
