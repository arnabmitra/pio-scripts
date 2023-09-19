#!/bin/bash

# Check if start and end block numbers are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 START_BLOCK END_BLOCK"
  exit 1
fi

START_BLOCK=$1
END_BLOCK=$2

# Iterate over the block range and count the number of messages in each block
for BLOCK in $(seq $START_BLOCK $END_BLOCK); do
  echo "Scanning block $BLOCK..."
  MESSAGE_COUNT=$(curl -s http://34.122.88.247:1317/cosmos/tx/v1beta1/txs/block/$BLOCK | jq '.txs[0].body.messages | length')
  echo "Block $BLOCK has $MESSAGE_COUNT messages"
done
