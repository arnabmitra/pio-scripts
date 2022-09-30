#!/bin/bash
x=1
PROVENANCE_DEV_DIR=~/provenance
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 keys add ownermarker --recover --hd-path "44'/1'/0'/0/0'" --keyring-backend test < ./mnemonics/ownermarker.txt

cd ${PROVENANCE_DEV_DIR}

if test -f ${PROVENANCE_DEV_DIR}/build/provenanced; then
    echo "provenanced exists."
else
    make build
fi
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

while [ $x -le 5 ]
do


 ${PROVENANCE_DEV_DIR}/build/provenanced tx bank send \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a ownermarker --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  1000000000000nhash \
  --from node0 \
  --home ${PROVENANCE_DEV_DIR}/build/node0 \
  --keyring-backend test --chain-id chain-local --gas auto --gas-adjustment 2  --gas-prices 1905nhash  \
  --testnet --yes -o json | jq
  x=$(( x+1 ))
done
