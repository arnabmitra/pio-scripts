#!/bin/bash



echo "Flushing packets"
#hermes --json --config ./hermes/config.toml start > /var/log/hermes.log
hermes --json --config ./hermes/config.toml  clear packets --port transfer --channel  channel-0 --chain testing -- --full-scan


