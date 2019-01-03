####################################################################################
# AXE Container
###############################################################################
FROM alpine:3.7
MAINTAINER kxseven

###############################################################################
# ENVs
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
  krb5 \
  ca-certificates


###############################################################################
# ARGs
###############################################################################


###############################################################################
# LABELs
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

WORKDIR /home/axe

ENTRYPOINT ["/bin/bash"]
