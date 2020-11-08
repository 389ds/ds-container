#!/bin/bash
podman stop $(podman ps -q) > /dev/null
podman rm $(podman container ls -a -q) > /dev/null
