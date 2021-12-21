#!/bin/bash

PROVENANCE_DEV_DIR=~/provenance
COMMON_TX_FLAGS="--gas auto --gas-prices 1905nhash --gas-adjustment 2 --chain-id chain-local --keyring-backend test --yes -o json"
COMMON_TX_WITH_FEES_FLAGS="--fees 382199010nhash,188gwei --chain-id chain-local --keyring-backend test --yes -o json"

######################################### SETUP FOR ATS CONTRACT EXECUTION ##############################################

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 keys add buyer --recover --keyring-backend test < ./mnemonics/buyer.txt
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 keys add seller --recover --keyring-backend test < ./mnemonics/seller.txt

export VALIDATOR_ID=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a node0 --home ${PROVENANCE_DEV_DIR}/build/node0 -t)
export BUYER=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a buyer --home ${PROVENANCE_DEV_DIR}/build/node0 -t)
export SELLER=$(${PROVENANCE_DEV_DIR}/build/provenanced keys show -a seller --home ${PROVENANCE_DEV_DIR}/build/node0 -t)

echo "Creating marker gme"

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker new 1000gme.local \
    --type COIN \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx marker grant ${VALIDATOR_ID} gme.local mint,burn,admin,withdraw,deposit \
    --from node0 \
${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker finalize gme.local \
    --from node0 \
${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx marker activate gme.local \
    --from node0 \
${COMMON_TX_FLAGS} | jq

###
#echo "Creating marker usd"
#
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker new 1000usd.local \
    --type COIN \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx marker grant ${VALIDATOR_ID} usd.local mint,burn,admin,withdraw,deposit \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker finalize usd.local \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx marker activate usd.local \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

## FUNDING ACCOUNTS STUFF
##
##
echo "Funding all accounts"

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker mint 100000usd.local \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq


${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
     tx marker mint 1000gme.local \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq
#
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 tx bank send ${VALIDATOR_ID} ${BUYER} 100000000000nhash  \
    --from node0 \
    ${COMMON_TX_WITH_FEES_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 tx marker withdraw usd.local 10000usd.local ${BUYER}  \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq
echo "${SELLER}"
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 tx bank send ${VALIDATOR_ID} ${SELLER} 100000000000nhash  \
    --from node0 \
    ${COMMON_TX_WITH_FEES_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 tx marker withdraw gme.local 1000gme.local ${SELLER}  \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq

${PROVENANCE_DEV_DIR}/build/provenanced -t  tx name bind \
    "sc" \
    "${VALIDATOR_ID}" \
    "pb" \
    --restrict=false \
    --from node0 \
    --home ${PROVENANCE_DEV_DIR}/build/node0 \
    ${COMMON_TX_FLAGS}| jq

######################################### DONE WITH SETUP FOR ATS CONTRACT EXECUTION ##############################################

# Wasm Contract Stuff
# This is the important stuff...everything else before this was setup for the main event
#
echo "Storing, instantiating, and executing ats contract"
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx wasm store wasms/ats_smart_contract.wasm  \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq


${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx wasm instantiate 1 \
    '{"name":"ats-ex", "bind_name":"ats-ex.sc.pb", "base_denom":"gme.local", "convertible_base_denoms":[], "supported_quote_denoms":["usd.local"], "approvers":[], "executors":["'${VALIDATOR_ID}'"], "ask_required_attributes":[], "bid_required_attributes":[], "price_precision": "0", "size_increment": "1"}' \
    --admin ${VALIDATOR_ID} \
    --label ats-ex \
    --from node0 \
    ${COMMON_TX_FLAGS} | jq
export ATS_EX=$(${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 q name resolve ats-ex.sc.pb --testnet | awk '{print $2}')
###
echo "Ats instantiated id is ${ATS_EX}"
###
###### WASM EXECUTES ###
echo "Creating an ask..."
ask_id=$(uuidgen)
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx wasm execute "${ATS_EX}" \
    '{"create_ask":{"id":"'"$ask_id"'", "base":"gme.local", "quote":"usd.local", "price": "2", "size":"500"}}' \
    --amount 500gme.local \
    --from seller \
    ${COMMON_TX_FLAGS} | jq
echo "Ask uuid id is ${ask_id}"
echo "Creating a bid..."
bid_id=$(uuidgen)
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx wasm execute ${ATS_EX} \
    '{"create_bid":{"id":"'"$bid_id"'", "base":"gme.local", "price": "2", "quote":"usd.local", "quote_size":"1000", "size":"500"}}' \
    --amount 1000usd.local \
    --from buyer \
    ${COMMON_TX_FLAGS} | jq
echo "Bid uuid id is ${bid_id}"

echo ""
echo "#############"
echo "Before Balances"
echo "#############"
echo ""
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    q bank balances ${BUYER}

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    q bank balances ${SELLER}

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    q bank balances ${VALIDATOR_ID}

echo "Match and execute orders..."
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    tx wasm execute ${ATS_EX} \
    '{"execute_match":{"ask_id":"'"$ask_id"'", "bid_id":"'"$bid_id"'", "price":"2", "size": "500"}}' \
    --from node0 \
    ${COMMON_TX_WITH_FEES_FLAGS}  | jq

echo ""
echo "#############"
echo "Show Balances"
echo "#############"
echo ""
${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    q bank balances ${BUYER}

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    q bank balances ${SELLER}

${PROVENANCE_DEV_DIR}/build/provenanced -t --home ${PROVENANCE_DEV_DIR}/build/node0 \
    q bank balances ${VALIDATOR_ID}
