#!/bin/bash
set -eu
source config.env
podman build -t $NAME -f $CONTAINERFILE
