#!/bin/bash

# Variables
silo_name=$1
wallet_name=$2
from_account="admin-1"
external=$4
coin_type=$3

if [ $# -lt 3 ]; then
    echo "Usage less thn 3: $0 <silo_name> <wallet_name> <coin_type> [--external]"
    exit 1
fi

# Check if silo name, wallet name, and coin type are provided
if [ -z "$silo_name" ] || [ -z "$wallet_name" ] || [ -z "$coin_type" ]; then
    echo "Usage no args: $0 <silo_name> <wallet_name> <coin_type> [--external]"
    exit 1
fi

# Check if silo exists
silo_exists=$(cord query wallet show-silo "$silo_name" --output json 2>/dev/null)

if [ -z "$silo_exists" ]; then
    # Silo does not exist, create it
    if [ "$external" == "--external" ]; then
        ./create_silo.sh "$silo_name" "This is a description" --external
    else
        ./create_silo.sh "$silo_name" "This is a description"
    fi
fi

# Create a wallet in the default vault
cord tx wallet generate-address "$silo_name" "$wallet_name" $coin_type --from $from_account

## Instructions for running
# Copy the script into the Docker container
# docker cp create_wallet.sh internal-api:/create_wallet.sh
# docker cp create_silo.sh internal-api:/create_silo.sh

# Add execute permissions to the script
# docker exec -it internal-api chmod +x /create_wallet.sh
# docker exec -it internal-api chmod +x /create_silo.sh

# Run the script in the Docker container
#docker exec -it internal-api /bin/bash -c "/create_wallet.sh 'ETH_SILO' 'ETHWallet' 'ETH' --external"
