#!/bin/bash
export VAULT_ADDR=
export KEY=
while true
do
    echo "Unseal at $(date "+%Y-%m-%d-%H-%M-%S")"
    vault operator unseal $KEY
    echo "Done"
    sleep 60
done