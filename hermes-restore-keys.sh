#!/bin/bash
set -e
# providing path to match golang relayer
hermes --config ~/.hermes/config.toml keys add --chain testing --key-name testing --mnemonic-file ./mnemonics/relayer.txt --hd-path="m/44'/118'/0'/0/0"

hermes --config ~/.hermes/config.toml keys add --chain testing2 --key-name testing2 --mnemonic-file ./mnemonics/relayer.txt --hd-path="m/44'/118'/0'/0/0"
