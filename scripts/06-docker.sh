#!/bin/sh -x

apk add docker

addgroup vagrant docker

# Enable the docker to start on startup.
rc-update add docker default
rc-update -u
