#!/bin/bash


# Start the hermes relayer in multi-paths mode
echo "Starting hermes relayer..."
 hermes --config ~/.hermes/config.toml update client --host-chain testing --client 07-tendermint-0

