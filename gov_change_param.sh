#!/bin/bash

# I'm using a provenance "run" instance for these tests
# provenance setup, clean project, make, adjust the voting period in the config to test msg based fee proposals:
# 'make clean ; make build; make run-config; cat ./build/node0/config/genesis.json | jq '\'' .app_state.gov.voting_params.voting_period="20s" '\'' | tee ./build/node0/config/genesis.json; cat ./build/node0/config/genesis.json'

PROVENANCE_DEV_DIR=~/provenance

COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

######################################## SETUP FOR GOV PROPOSAL ##############################################

${PROVENANCE_DEV_DIR}/build/provenanced tx gov submit-proposal param-change ~/pio-scratch/param-change-proposal.json \
     --from node0 \
     --home ${PROVENANCE_DEV_DIR}/build/node0 \
     --chain-id chain-local \
 		 --keyring-backend test \
     --fees 1000000000nhash  \
     --gas auto \
     --gas-adjustment 2 \
     --broadcast-mode block \
     --yes \
     --testnet

${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote 1 yes \
	--from node0 \
  --home ${PROVENANCE_DEV_DIR}/build/node0 \
  --chain-id chain-local \
	--keyring-backend test \
    --gas-prices 1905nhash \
        --gas 150000 \
  --broadcast-mode block \
  --yes \
  --testnet

${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote 1 yes \
--from node1 \
--home ${PROVENANCE_DEV_DIR}/build/node1 \
--chain-id chain-local \
--keyring-backend test \
 --gas-prices 1905nhash \
        --gas 150000 \
--broadcast-mode block \
--yes \
--testnet

${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote 1 yes \
--from node2 \
--home ${PROVENANCE_DEV_DIR}/build/node2 \
--chain-id chain-local \
--keyring-backend test \
  --gas-prices 1905nhash \
      --gas 150000 \
--broadcast-mode block \
--yes \
--testnet

${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote 1 yes \
--from node3 \
--home ${PROVENANCE_DEV_DIR}/build/node3 \
--chain-id chain-local \
--keyring-backend test \
  --gas-prices 1905nhash \
      --gas 150000 \
--broadcast-mode block \
--yes \
--testnet
