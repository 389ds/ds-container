#!/bin/bash
set -eu
source config.env
podman build --no-cache -t $TAG -f $CONTAINERFILE
