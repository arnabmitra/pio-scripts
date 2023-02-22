#!/bin/bash

PROVENANCE_DEV_DIR=~/provenance

${PROVENANCE_DEV_DIR}/build/provenanced tx marker mint 2000000000000vspn --from validator \
    --home ${PROVENANCE_DEV_DIR}/build/run/provenanced \
    --keyring-backend test --chain-id pio-usdf-mainnet-1 --gas auto --gas-adjustment 2   \
     --yes -o json | jq

     ${PROVENANCE_DEV_DIR}/build/provenanced  tx marker withdraw vspn 2000000000000vspn pb1rw9pcj9d6awz7e5x42m93q6dztfk8n6jcuuvqq \
      --from validator \
      --home ${PROVENANCE_DEV_DIR}/build/run/provenanced \
      --keyring-backend test --chain-id pio-usdf-mainnet-1 --gas auto --gas-adjustment 2   \
      --yes -o json | jq