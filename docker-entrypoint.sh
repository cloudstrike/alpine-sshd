#!/bin/sh
SSH_USER=${SSH_USER:-"toronz"}
if [ -z "${AUTHORIZED_KEYS}" ]; then
  echo "Missing ssh public key URL inside AUTHORIZED_KEYS env variable. Defaulting to Github SSH public key using SSH_USER..."
  AUTHORIZED_KEYS="https://github.com/${SSH_USER}.keys"
  echo "Fetching public key from ${AUTHORIZED_KEYS}..."
fi

adduser --disabled-password --gecos "" "${SSH_USER}"
passwd -u "${SSH_USER}"
mkdir -p /home/"${SSH_USER}"/.ssh

echo "Populating /root/.ssh/authorized_keys with the key downloaded from AUTHORIZED_KEYS env variable ..."
curl -LSo /home/"${SSH_USER}"/.ssh/authorized_keys "${AUTHORIZED_KEYS}"
chown -R "${SSH_USER}":"${SSH_USER}" /home/"${SSH_USER}"/.ssh

# Execute the CMD from the Dockerfile:
exec "$@"
