#!/bin/bash
export VAULT_ADDR=
export TOKEN=
vault login $TOKEN
vault token create -policy=$1 -period=30000h
