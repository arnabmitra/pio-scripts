## i want a cript that creates a silo which takes in a silo name, description, --from default to admin-1 and if external
## cord tx wallet create-account to "Simulates a transfer to  wallet for the exchange." --from admin-1
## cord tx wallet create-account to-external  "Simulates a transfer to  wallet for the exchange." --external --from admin-1
#!/bin/bash

# Variables
silo_name=$1
description=$2
from_account="admin-1"
external=$3

# Check if silo name and description are provided
if [ -z "$silo_name" ] || [ -z "$description" ]; then
    echo "Usage: $0 <silo_name> <description> [--external]"
    exit 1
fi

# Create account
cord tx wallet create-account "$silo_name" "$description" --from $from_account

# Check if external flag is provided
if [ "$external" == "--external" ]; then
    # Create external account
    cord tx wallet create-account "$silo_name" "$description" --external --from $from_account
fi

## Instructions for running
# Copy the script into the Docker container
#docker cp create_silo.sh internal-api:/create_silo.sh

# Add execute permissions to the script
#docker exec -it internal-api chmod +x /create_silo.sh

# Run the script in the Docker container
#docker exec -it internal-api /bin/bash -c "/create_silo.sh 'MySilo' 'This is a description' --external"
