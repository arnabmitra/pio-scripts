#!/bin/bash

PROVENANCE_DEV_DIR=~/provenance


provenanced --testnet
keys add alice --hd-path="44'/1'/0'/0/0" --home ${PROVENANCE_DEV_DIR}/build/node0
provenanced --testnet keys add bob --hd-path="44'/1'/0'/0/0" --home ${PROVENANCE_DEV_DIR}/build/node0
provenanced --testnet keys add chuck --hd-path="44'/1'/0'/0/0" --home ${PROVENANCE_DEV_DIR}/build/node0

# This is a comment
export ALICE=$(provenanced keys show alice --address --testnet --home ${PROVENANCE_DEV_DIR}/build/node0)
export BOB=$(provenanced keys show bob --address --testnet --home ${PROVENANCE_DEV_DIR}/build/node0)
export CHUCK=$(provenanced keys show chuck --address --testnet --home ${PROVENANCE_DEV_DIR}/build/node0)

env | grep 'ALICE\|BOB\|CHUCK'
alice=${ALICE}
bob=${BOB}
chuck=${CHUCK}
members="{
               \"members\": [
                   {
                       \"address\": \"${alice}\",
                       \"weight\": \"1\",
                       \"metadata\": \"alice\"
                   },
                   {
                       \"address\": \"${bob}\",
                       \"weight\": \"1\",
                       \"metadata\": \"bob\"
                   },
                   {
                       \"address\": \"${chuck}\",
                       \"weight\": \"1\",
                       \"metadata\": \"chuck\"
                   }
               ]
           }"

           file_name="members.json"
           echo "$members" > "$file_name"

            ${PROVENANCE_DEV_DIR}/build/provenanced tx bank send node0 "${alice}" 1000000000000nhash --home ${PROVENANCE_DEV_DIR}/build/node0  \
                --chain-id chain-local \
                --gas auto --gas-adjustment 1.25 --gas-prices 1905nhash \
                --testnet \
                --broadcast-mode block \
                --yes \
                --testnet -o json

           ${PROVENANCE_DEV_DIR}/build/provenanced tx group create-group "${alice}" --home ${PROVENANCE_DEV_DIR}/build/node0  \
              "foo-bar-baz" \
              ./members.json \
              --chain-id chain-local \
              --gas auto --gas-adjustment 1.25 --gas-prices 1905nhash \
              --testnet \
              --broadcast-mode block \
              --yes \
              --testnet -o json

            group_members=$(${PROVENANCE_DEV_DIR}/build/provenanced q group groups-by-admin "${alice}" --home ${PROVENANCE_DEV_DIR}/build/node0 --output json| jq '.groups[] | .id')
            echo "$group_members"

#           cleanup() {
#               rm -f "$temp_file"
#           }
#
#           trap cleanup EXIT