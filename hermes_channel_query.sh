#!/bin/bash

hermes --config ~/.hermes/config.toml query channels --chain testing

hermes --config ~/.hermes/config.toml query  connections --chain testing

hermes --config ~/.hermes/config.toml query  connection end --chain testing  --connection connection-0

hermes --config ~/.hermes/config.toml query channel end --chain testing2  --port transfer --channel channel-0

hermes --config ~/.hermes/config.toml query channel end --chain testing  --port transfer --channel channel-0