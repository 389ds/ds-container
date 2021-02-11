#!/bin/bash 
dsconf localhost config replace nsslapd-rootpw=password
dsconf localhost config replace nsslapd-allow-anonymous-access=off
dsconf localhost backend create --suffix="dc=example,dc=com" --be-name userRoot

