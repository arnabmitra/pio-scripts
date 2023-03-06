#!/bin/bash


# Start the hermes relayer in multi-paths mode
echo "Starting hermes relayer..."
hermes --json --config ./hermes/config.toml start > /var/log/hermes.log
#hermes --json --config ./hermes/config.toml start
