#!/bin/bash
x=1
PROVENANCE_DEV_DIR=~/provenance
# Check if ownermarker key already exists before adding
if ! ${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/run keys show ownermarker --keyring-backend test > /dev/null 2>&1; then
    ${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/run keys add ownermarker --recover --hd-path "44'/1'/0'/0/0'" --keyring-backend test < ./mnemonics/ownermarker.txt
    echo "Added ownermarker key"
else
    echo "ownermarker key already exists, skipping key addition"
fi

cd ${PROVENANCE_DEV_DIR}

COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

while [ $x -le 2 ]
do


 tx_hash=$(${PROVENANCE_DEV_DIR}/build/provenanced tx bank send \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a ownermarker --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  100000000000nhash \
  --from node0 \
  --home ${PROVENANCE_DEV_DIR}/build/node0 \
  --keyring-backend test --chain-id chain-local --gas auto --gas-adjustment 2  --gas-prices 1905nhash  \
  --testnet --yes -o json | jq -r '.txhash')
  x=$(( x+1 ))

  while true; do
      sleep 3
        status=$(${PROVENANCE_DEV_DIR}/build/provenanced query tx $tx_hash --output json | jq -r '.code')
        if [ -z "$status" ]; then
            echo "Transaction $tx_hash is still pending..."
            sleep 3
        else
            echo "Transaction $tx_hash confirmed in a block!"
            break
        fi
    done
done
