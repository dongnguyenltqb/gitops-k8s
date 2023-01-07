#!/bin/bash
if [[ -z $1 ]]; then
    echo "Please pass the value"
    exit 1
fi
kubeseal --fetch-cert > cert.pem
echo "Encrypted: $1"
echo -n $1 | kubeseal --raw --scope cluster-wide --cert cert.pem
rm cert.pem
