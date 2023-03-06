#!/bin/bash


PROVENANCE_DEV_DIR=~/provenance
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"
 ADDRESS_CHAIN_2=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a  ibc1-0 -t --home ${PROVENANCE_DEV_DIR}/build/ibc1-0/ )
BALANCE_CHAIN_2=$(${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/ibc1-0/ q bank balances "${ADDRESS_CHAIN_2}" --node http://localhost:26660)

printf '%s balance on chain 2 \n' "$BALANCE_CHAIN_2"

