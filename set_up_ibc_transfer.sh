#!/bin/bash


PROVENANCE_DEV_DIR=~/provenance
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"
docker exec -it $(docker container ls -qf "name=relayer")  sh -c "rly --home /relayer paths list"
docker exec -it $(docker container ls -qf "name=relayer")  sh -c "rly --home /relayer query clients local"
 ADDRESS_CHAIN_2=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a  ibc1-0 -t --home ${PROVENANCE_DEV_DIR}/build/ibc1-0/ )
 # shellcheck disable=SC2059
printf '%s address chain 2: \n' "$ADDRESS_CHAIN_2"
  ADDRESS_CHAIN_1=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a  ibc0-0 -t --home ${PROVENANCE_DEV_DIR}/build/ibc0-0/ )
printf '%s address chain 1:\n' "$ADDRESS_CHAIN_1"
${PROVENANCE_DEV_DIR}/build/provenanced -t tx ibc-transfer transfer transfer channel-0 "${ADDRESS_CHAIN_2}" \
500nhash --from ibc0-0 --gas auto --gas-prices 1905nhash --gas-adjustment 1.5 \
--home ${PROVENANCE_DEV_DIR}/build/ibc0-0/ --chain-id testing --node http://localhost:26657 -y -o json | jq
sleep 10
BALANCE_CHAIN_2=$(${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/ibc1-0/ q bank balances "${ADDRESS_CHAIN_2}" --node http://localhost:26660)

printf '%s balance on chain 2 \n' "$BALANCE_CHAIN_2"

