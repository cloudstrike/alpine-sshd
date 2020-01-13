#!/bin/sh
SSH_USER=${SSH_USER:-"toronz"}
if [ -z "${AUTHORIZED_KEYS}" ]; then
  echo "Missing ssh public key URL inside AUTHORIZED_KEYS env variable. Defaulting to Github SSH public key using SSH_USER..."
  AUTHORIZED_KEYS="https://github.com/${SSH_USER}.keys"
  exit 1
fi

adduser --disabled-password --gecos "" "${SSH_USER}"

echo "Populating /root/.ssh/authorized_keys with the key downloaded from AUTHORIZED_KEYS env variable ..."
curl -LSo /home/"${SSH_USER}"/.ssh/authorized_keys "${AUTHORIZED_KEYS}"

# Execute the CMD from the Dockerfile:
exec "$@"
