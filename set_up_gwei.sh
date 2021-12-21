#!/bin/bash

# I'm using a provenance "run" instance for these tests
# provenance setup, clean project, make, adjust the voting period in the config to test msg based fee proposals:
# 'make clean ; make build; make run-config; cat ./build/node0/config/genesis.json | jq '\'' .app_state.gov.voting_params.voting_period="20s" '\'' | tee ./build/node0/config/genesis.json; cat ./build/node0/config/genesis.json'

PROVENANCE_DEV_DIR=~/provenance
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 keys add ownermarker --recover --hd-path "44'/1'/0'/0/0'" --keyring-backend test < ./mnemonics/ownermarker.txt
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

 ${PROVENANCE_DEV_DIR}/build/provenanced tx bank send \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home build/node0 --keyring-backend test --testnet) \
  $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a ownermarker --home build/node0 --keyring-backend test --testnet) \
  1000000000000nhash \
  --from node0 \
  --home ${PROVENANCE_DEV_DIR}/build/node0 \
  ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker new 0gwei \
    --type COIN \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t tx marker grant \
    $(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
    gwei \
    admin,burn,deposit,delete,mint,withdraw \
    --from node0 \
    --home ${PROVENANCE_DEV_DIR}/build/node0 \
    ${COMMON_TX_FLAGS} | jq

#
${PROVENANCE_DEV_DIR}/build/provenanced -t tx marker finalize gwei \
    --from node0 \
    --keyring-backend test \
    --home ${PROVENANCE_DEV_DIR}/build/node0 \
     ${COMMON_TX_FLAGS} |jq
#
${PROVENANCE_DEV_DIR}/build/provenanced -t  tx marker activate gwei \
    --from node0 \
    --keyring-backend test \
    --home ${PROVENANCE_DEV_DIR}/build/node0 \
    ${COMMON_TX_FLAGS} |jq

${PROVENANCE_DEV_DIR}/build/provenanced -t tx marker mint 200000gwei \
    --from node0 \
    --keyring-backend test \
    --home ${PROVENANCE_DEV_DIR}/build/node0 \
     ${COMMON_TX_FLAGS} |jq
#
${PROVENANCE_DEV_DIR}/build/provenanced -t tx marker withdraw gwei 100000gwei $(provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
        --from node0 \
        --keyring-backend test \
        --home ${PROVENANCE_DEV_DIR}/build/node0 \
     ${COMMON_TX_FLAGS} |jq


${PROVENANCE_DEV_DIR}/build/provenanced -t tx marker withdraw gwei 100000gwei $(provenanced keys show -a ownermarker --home ${PROVENANCE_DEV_DIR}/build/node0 --keyring-backend test --testnet) \
        --from node0 \
        --keyring-backend test \
        --home ${PROVENANCE_DEV_DIR}/build/node0 \
     ${COMMON_TX_FLAGS} |jq
