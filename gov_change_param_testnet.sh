#!/bin/bash

# I'm using a provenance "run" instance for these tests
# provenance setup, clean project, make, adjust the voting period in the config to test msg based fee proposals:
# 'make clean ; make build; make run-config; cat ./build/node0/config/genesis.json | jq '\'' .app_state.gov.voting_params.voting_period="20s" '\'' | tee ./build/node0/config/genesis.json; cat ./build/node0/config/genesis.json'

#PROVENANCE_DEV_DIR=~/provenance
#
#COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"

######################################## SETUP FOR GOV PROPOSAL ##############################################

~/provenance/build/provenanced -t tx msgfees proposal add "adding"  \
  "Additional fee for MsgCreateGroup" 50000000000000nhash \
  --msg-type=/cosmos.group.v1.MsgCreateGroup --additional-fee=50000_000_000_000nhash \
  --from ibc-pio-testnet \
  --chain-id pio-testnet-1 \
  --keyring-backend os \
  --gas auto --gas-adjustment 1.4 --fees 100900352060nhash \
  --testnet --node=https://rpc.test.provenance.io:443 -o json | jq

#  | jq '.logs[ ] .events[] | select(.type=="submit_proposal") .attributes[]| select(.key=="proposal_id") .value')
#GOV_PROP=$(sed -e 's/^"//' -e 's/"$//' <<<"$GOV_PROP")
# shellcheck disable=SC2086
#printf $GOV_PROP
#
#${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote $GOV_PROP yes \
#  --from node0 \
#  --home ${PROVENANCE_DEV_DIR}/build/node0 \
#  --chain-id chain-local \
#  --keyring-backend test \
#  --gas-prices 1905nhash \
#  --gas 150000 \
#  --broadcast-mode block \
#  --yes \
#  --testnet
#
#${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote $GOV_PROP yes \
#  --from node1 \
#  --home ${PROVENANCE_DEV_DIR}/build/node1 \
#  --chain-id chain-local \
#  --keyring-backend test \
#  --gas-prices 1905nhash \
#  --gas 150000 \
#  --broadcast-mode block \
#  --yes \
#  --testnet
#
#${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote $GOV_PROP yes \
#  --from node2 \
#  --home ${PROVENANCE_DEV_DIR}/build/node2 \
#  --chain-id chain-local \
#  --keyring-backend test \
#  --gas-prices 1905nhash \
#  --gas 150000 \
#  --broadcast-mode block \
#  --yes \
#  --testnet
#
#${PROVENANCE_DEV_DIR}/build/provenanced -t tx gov vote "$GOV_PROP" yes \
#  --from node3 \
#  --home ${PROVENANCE_DEV_DIR}/build/node3 \
#  --chain-id chain-local \
#  --keyring-backend test \
#  --gas-prices 1905nhash \
#  --gas 150000 \
#  --broadcast-mode block \
#  --yes \
#  --testnet
