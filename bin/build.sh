#!/bin/bash
set -eu
source config.env
podman build -t $TAG -f $CONTAINERFILE
