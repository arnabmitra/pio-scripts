#!/bin/bash

hermes --config ~/.hermes/config.toml query channels --chain testing

hermes --config ~/.hermes/config.toml query  connections --chain testing

hermes --config ~/.hermes/config.toml query  connection end --chain testing  --connection connection-0