#!/bin/bash


PROVENANCE_DEV_DIR=~/provenance
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"


  ADDRESS_CHAIN_1=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a  ibc0-0 -t --home ${PROVENANCE_DEV_DIR}/build/ibc0-0/ )
printf '%s address chain 1:\n' "$ADDRESS_CHAIN_1"
${PROVENANCE_DEV_DIR}/build/provenanced -t tx bank send "${ADDRESS_CHAIN_1}" tp10j9gpw9t4jsz47qgnkvl5n3zlm2fz72kkfw5cz \
500000000000nhash --from ibc0-0 --gas auto --gas-prices 1905nhash --gas-adjustment 1.5 \
--home ${PROVENANCE_DEV_DIR}/build/ibc0-0/ --chain-id testing --node http://localhost:26657 -y -o json | jq

${PROVENANCE_DEV_DIR}/build/provenanced tx name bind send\
                "${ADDRESS_CHAIN_1}" \
                "" \
                --from ibc0-0 \
                --keyring-backend test \
                --home ${PROVENANCE_DEV_DIR}/build/ibc0-0/ \
                --chain-id testing \
                --fees 381000000nhash \
                --broadcast-mode block \
                --yes \
                --testnet | jq


