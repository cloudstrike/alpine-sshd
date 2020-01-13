#!/bin/sh
if [ -z "${AUTHORIZED_KEYS}" ]; then
  echo "Set your ssh public key as URL inside AUTHORIZED_KEYS env variable. Exiting..."
  exit 1
fi

echo "Populating /root/.ssh/authorized_keys with the key downloaded from AUTHORIZED_KEYS env variable ..."
curl -LSo /root/.ssh/authorized_keys "${AUTHORIZED_KEYS}"

# Execute the CMD from the Dockerfile:
exec "$@"
