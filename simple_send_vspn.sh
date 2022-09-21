#!/bin/bash
x=1
PROVENANCE_DEV_DIR=~/provenance
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 keys add ownermarker --recover --hd-path "44'/1'/0'/0/0'" --keyring-backend test < ./mnemonics/ownermarker.txt
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

while [ $x -le 5 ]
do


 ${PROVENANCE_DEV_DIR}/build/provenanced tx bank send \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  tp1t6urmuke2r2qnv23ts0t3qjp65ffp2vc529y0j \
  1000000000vspn \
  --from node0 \
  --home ${PROVENANCE_DEV_DIR}/build/node0 \
  --keyring-backend test --chain-id chain-local --gas auto --gas-adjustment 2  --fees 0vspn  \
  --testnet --yes -o json | jq
  x=$(( x+1 ))
done
