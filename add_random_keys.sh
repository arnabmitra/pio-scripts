#!/bin/bash

PROVENANCE_DEV_DIR=~/provenance


provenanced --testnet keys add alice --hd-path="44'/1'/0'/0/0" --home ${PROVENANCE_DEV_DIR}/build/
provenanced --testnet keys add bob --hd-path="44'/1'/0'/0/0" --home ${PROVENANCE_DEV_DIR}/build/
provenanced --testnet keys add chuck --hd-path="44'/1'/0'/0/0" --home ${PROVENANCE_DEV_DIR}/build/

# This is a comment
export ALICE=$(provenanced keys show alice --address --testnet --home ${PROVENANCE_DEV_DIR}/build/)
export BOB=$(provenanced keys show bob --address --testnet --home ${PROVENANCE_DEV_DIR}/build/)
export CHUCK=$(provenanced keys show chuck --address --testnet --home ${PROVENANCE_DEV_DIR}/build/)

env | grep 'ALICE\|BOB\|CHUCK'
alice=${ALICE}
bob=${BOB}
chuck=${CHUCK}

echo ${ALICE}

provenanced -t --home ${PROVENANCE_DEV_DIR}/build/ keys add ownermarker --recover --hd-path "m/44'/118'/0'/0/0" --keyring-backend test < ./mnemonics/relayer.txt