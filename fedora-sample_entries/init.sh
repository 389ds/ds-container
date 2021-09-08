#!/bin/bash
set -eux

DSC=/usr/libexec/dirsrv/dscontainer

# Start dscontainer in the background to do some configuration first
$DSC -r &
DSC_PID=$!

# Initial sleep to avoid a race condition in the healthcheck
sleep 15

# Wait until server is up
max_retry=30
counter=0
set +e
until $DSC -H
do
   sleep 1
   [[ counter -eq $max_retry ]] && echo "Failed to start the server!" && exit 1
   echo "Trying again. Try #$counter"
   ((counter++))
done
set -e

### INSERT YOUR CUSTOMIZATIONS HERE ###
echo "Creating a new backend"
dsconf localhost backend create --suffix="dc=example,dc=com" --be-name userRoot --create-suffix --create-entries
echo "Creating a new user"
dsidm localhost --basedn dc=example,dc=com user create --uid ldap_user --cn ldap_user --displayName "Ldap User" --uidNumber 1001 --gidNumber 1001 --homeDirectory /home/ldap_user
echo "Setting a password for the new user"
dsidm localhost --basedn dc=example,dc=com account reset_password uid=ldap_user,ou=people,dc=example,dc=com Secret123
###  END OF CUSTOMIZATION SECTION   ###

kill -15 $DSC_PID
