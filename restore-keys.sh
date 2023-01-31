#!/bin/bash
set -e


### Sleep is needed otherwise the relayer crashes when trying to init
sleep 1
hermes --config ~/.hermes/config.toml keys add --chain testing --key-name testing --mnemonic-file ./mnemonics/relayer.txt --hd-path="m/44'/118'/0'/0/0"
sleep 5

hermes --config ~/.hermes/config.toml keys add --chain testing2 --key-name testing2 --mnemonic-file ./mnemonics/relayer.txt --hd-path="m/44'/118'/0'/0/0"
sleep 5
