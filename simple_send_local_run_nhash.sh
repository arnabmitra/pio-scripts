#!/bin/bash
x=1
PROVENANCE_DEV_DIR=~/provenance
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/run keys add ownermarker --recover --hd-path "44'/1'/0'/0/0'" --keyring-backend test < ./mnemonics/ownermarker.txt
COMMON_TX_FLAGS="--gas 1000000 --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

while [ $x -le 1 ]
do


 ${PROVENANCE_DEV_DIR}/build/provenanced tx bank send \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a validator --home ${PROVENANCE_DEV_DIR}/build/run/provenanced --keyring-backend test --testnet) \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a ownermarker --home ${PROVENANCE_DEV_DIR}/build/run --keyring-backend test --testnet) \
  1000000nhash \
  --from validator \
  --home ${PROVENANCE_DEV_DIR}/build/run/provenanced \
  --keyring-backend test --chain-id testing --fees 391000000nhash  \
  --testnet --yes -o json | jq
  x=$(( x+1 ))
done
