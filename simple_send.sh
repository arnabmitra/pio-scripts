#!/bin/bash


PROVENANCE_DEV_DIR=~/provenance
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 keys add ownermarker --recover --hd-path "44'/1'/0'/0/0'" --keyring-backend test < ./mnemonics/ownermarker.txt
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

 ${PROVENANCE_DEV_DIR}/build/provenanced tx bank send \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a ownermarker --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
  1000000000000nhash \
  --from node0 \
  --home ${PROVENANCE_DEV_DIR}/build/node0 \
  --keyring-backend test --chain-id chain-local --fees 382199010nhash --broadcast-mode block --yes \
  --testnet -o json | jq
