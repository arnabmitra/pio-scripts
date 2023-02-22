#!/bin/bash

PROVENANCE_DEV_DIR=~/provenance

provenanced tx staking create-validator \
  --amount=2000000000000vspn \
  --pubkey=$(provenanced tendermint show-validator) \
  --moniker="moniker-a" \
  --chain-id=pio-usdf-mainnet-1 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="100" \
  --gas="auto" \
  --gas-adjustment 2 \
  --from=add-validator