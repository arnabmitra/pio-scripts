#!/bin/bash

# Get command line arguments
address=$1
rpc_url=$2
flag=$3

PROVENANCE_DEV_DIR=~/provenance

# Check if argument is empty
if [[ -z "$rpc_url" ]]; then
  rpc_url="tcp://localhost:26657"
fi

if [[ -z "$flag" ]]; then
  flag="-t"
fi

# Make the JSON RPC call
response=$(${PROVENANCE_DEV_DIR}/build/provenanced "$flag" q bank balances "${address}" --node="$rpc_url")


echo "Address: $address"
# Print the balance
echo "Balance: $response"