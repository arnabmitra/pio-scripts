#!/bin/bash
 # make a request to  https://service-explorer.provenance.io/api/v2/txs/recent?count=200&page=1&msgType=instantiate_contract&txStatus=SUCCESS
  # and get the txHash from the response
# example response: {
                    #"pages": 176,
                    #"results": [
                    #{
                    #"txHash": "D32E53660B19AB32F9FCA25D994FE5BAF241FC1B9E856A6604A9A7302C265694",
                    #"block": 10143182,
                    #"msg": {
                    #"msgCount": 1,
                    #"displayMsgType": "instantiate_contract"
                    #},
                    #"monikers": {},
                    #"time": "2023-03-23T17:29:37.162Z",
                    #"fee": {
                    #"amount": "10700000000",
                    #"denom": "nhash"
                    #},
                    #"signers": [
                    #{
                    #"idx": 0,
                    #"type": "secp256k1",
                    #"address": "pb122helvp42nc5mx0wfahc8wuauc4wjryafrrsr6",
                    #"sequence": 8
                    #}
                    #],
                    #"status": "success",
                    #"feepayer": {
                    #"type": "FIRST_SIGNER",
                    #"address": "pb122helvp42nc5mx0wfahc8wuauc4wjryafrrsr6"
                    #}
                    #}
                    #],
                    #"total": 176,
                    #"rollupTotals": {}
                    #}


               curl 'https://service-explorer.provenance.io/api/v2/txs/recent?count=200&page=1&msgType=instantiate_contract&txStatus=SUCCESS' \
            | jq '.results[].txHash' > txHashes.txt
# read the txHashes.txt file, remove  quotes from each line and make a request to https://service-explorer.provenance.io/api/v2/txs/{txHash}
while read -r line; do
    line=$(echo $line | tr -d '"')
    echo "Text read from file: $line"
    #{
         #  "txHash": "E26475835422235396AC4A72AB55B4320F5D8F0F5DD88AD73F69026C7BA8DA8C",
         #  "height": 10037864,
         #  "gas": {
         #    "gasUsed": 237957,
         #    "gasWanted": 4000000,
         #    "gasPrice": {
         #      "amount": "1905",
         #      "denom": "nhash"
         #    }
         #  },
         #  "time": "2023-03-16T17:05:27.529586273Z",
         #  "status": "success",
         #  "errorCode": 0,
         #  "codespace": "",
         #  "errorLog": null,
         #  "fee": [
         #    {
         #      "type": "Base Fee Used",
         #      "fees": [
         #        {
         #          "amount": "453308085",
         #          "denom": "nhash",
         #          "msgType": null,
         #          "recipient": null,
         #          "origFees": null
         #        }
         #      ]
         #    },
         #    {
         #      "type": "Base Fee Overage",
         #      "fees": [
         #        {
         #          "amount": "7166691915",
         #          "denom": "nhash",
         #          "msgType": null,
         #          "recipient": null,
         #          "origFees": null
         #        }
         #      ]
         #    },
         #    {
         #      "type": "Msg Based Fee",
         #      "fees": [
         #        {
         #          "amount": "100000000000",
         #          "denom": "nhash",
         #          "msgType": "add_marker",
         #          "recipient": null,
         #          "origFees": null
         #        }
         #      ]
         #    }
         #  ],
         #  "signers": [
         #    {
         #      "idx": 0,
         #      "type": "secp256k1",
         #      "address": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g",
         #      "sequence": 4
         #    }
         #  ],
         #  "memo": "",
         #  "monikers": {},
         #  "feepayer": {
         #    "type": "FIRST_SIGNER",
         #    "address": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #  },
         #  "associatedValues": [
         #    {
         #      "value": "cusd.deposit",
         #      "type": "DENOM"
         #    },
         #    {
         #      "value": "21",
         #      "type": "CODE"
         #    },
         #    {
         #      "value": "pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29",
         #      "type": "CONTRACT"
         #    },
         #    {
         #      "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g",
         #      "type": "ACCOUNT"
         #    }
         #  ],
         #  "additionalHeights": [],
         #  "events": [
         #    {
         #      "type": "coin_spent",
         #      "attributes": [
         #        {
         #          "key": "spender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        },
         #        {
         #          "key": "amount",
         #          "value": "7620000000nhash"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "coin_received",
         #      "attributes": [
         #        {
         #          "key": "receiver",
         #          "value": "pb17xpfvakm2amg962yls6f84z3kell8c5lehg9xp"
         #        },
         #        {
         #          "key": "amount",
         #          "value": "7620000000nhash"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "transfer",
         #      "attributes": [
         #        {
         #          "key": "recipient",
         #          "value": "pb17xpfvakm2amg962yls6f84z3kell8c5lehg9xp"
         #        },
         #        {
         #          "key": "sender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        },
         #        {
         #          "key": "amount",
         #          "value": "7620000000nhash"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "message",
         #      "attributes": [
         #        {
         #          "key": "sender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "tx",
         #      "attributes": [
         #        {
         #          "key": "fee",
         #          "value": "107620000000nhash"
         #        },
         #        {
         #          "key": "fee_payer",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "tx",
         #      "attributes": [
         #        {
         #          "key": "min_fee_charged",
         #          "value": "7620000000nhash"
         #        },
         #        {
         #          "key": "fee_payer",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "tx",
         #      "attributes": [
         #        {
         #          "key": "acc_seq",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g/4"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "tx",
         #      "attributes": [
         #        {
         #          "key": "signature",
         #          "value": "GZmDIsS81IBLBdnbhmdQvnVuZ6mP3LOYfkUmwLIZzQhkEBAAL9NtyJ2mD9kibWhKY6rX8Rh1n8G+7vqgO/0JNg=="
         #        }
         #      ]
         #    },
         #    {
         #      "type": "message",
         #      "attributes": [
         #        {
         #          "key": "action",
         #          "value": "/cosmwasm.wasm.v1.MsgInstantiateContract"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "message",
         #      "attributes": [
         #        {
         #          "key": "module",
         #          "value": "wasm"
         #        },
         #        {
         #          "key": "sender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "instantiate",
         #      "attributes": [
         #        {
         #          "key": "_contract_address",
         #          "value": "pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29"
         #        },
         #        {
         #          "key": "code_id",
         #          "value": "21"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "provenance.marker.v1.EventMarkerAdd",
         #      "attributes": [
         #        {
         #          "key": "amount",
         #          "value": "\"0\""
         #        },
         #        {
         #          "key": "denom",
         #          "value": "\"cusd.deposit\""
         #        },
         #        {
         #          "key": "manager",
         #          "value": "\"pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29\""
         #        },
         #        {
         #          "key": "marker_type",
         #          "value": "\"MARKER_TYPE_RESTRICTED\""
         #        },
         #        {
         #          "key": "status",
         #          "value": "\"proposed\""
         #        }
         #      ]
         #    },
         #    {
         #      "type": "provenance.marker.v1.EventMarkerAddAccess",
         #      "attributes": [
         #        {
         #          "key": "access",
         #          "value": "{\"address\":\"pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29\",\"permissions\":[\"ACCESS_ADMIN\",\"ACCESS_BURN\",\"ACCESS_DEPOSIT\",\"ACCESS_DELETE\",\"ACCESS_MINT\",\"ACCESS_TRANSFER\",\"ACCESS_WITHDRAW\"]}"
         #        },
         #        {
         #          "key": "administrator",
         #          "value": "\"pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29\""
         #        },
         #        {
         #          "key": "denom",
         #          "value": "\"cusd.deposit\""
         #        }
         #      ]
         #    },
         #    {
         #      "type": "provenance.marker.v1.EventMarkerAddAccess",
         #      "attributes": [
         #        {
         #          "key": "access",
         #          "value": "{\"address\":\"pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g\",\"permissions\":[\"ACCESS_ADMIN\"]}"
         #        },
         #        {
         #          "key": "administrator",
         #          "value": "\"pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29\""
         #        },
         #        {
         #          "key": "denom",
         #          "value": "\"cusd.deposit\""
         #        }
         #      ]
         #    },
         #    {
         #      "type": "provenance.marker.v1.EventMarkerFinalize",
         #      "attributes": [
         #        {
         #          "key": "administrator",
         #          "value": "\"pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29\""
         #        },
         #        {
         #          "key": "denom",
         #          "value": "\"cusd.deposit\""
         #        }
         #      ]
         #    },
         #    {
         #      "type": "provenance.marker.v1.EventMarkerActivate",
         #      "attributes": [
         #        {
         #          "key": "administrator",
         #          "value": "\"pb1fmzvg3348ju470xzkp5zswxdewzmw75wrz6u0cdpt0ys2utezt6qytdr29\""
         #        },
         #        {
         #          "key": "denom",
         #          "value": "\"cusd.deposit\""
         #        }
         #      ]
         #    },
         #    {
         #      "type": "coin_spent",
         #      "attributes": [
         #        {
         #          "key": "spender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        },
         #        {
         #          "key": "amount",
         #          "value": "100000000000nhash"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "coin_received",
         #      "attributes": [
         #        {
         #          "key": "receiver",
         #          "value": "pb17xpfvakm2amg962yls6f84z3kell8c5lehg9xp"
         #        },
         #        {
         #          "key": "amount",
         #          "value": "100000000000nhash"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "transfer",
         #      "attributes": [
         #        {
         #          "key": "recipient",
         #          "value": "pb17xpfvakm2amg962yls6f84z3kell8c5lehg9xp"
         #        },
         #        {
         #          "key": "sender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        },
         #        {
         #          "key": "amount",
         #          "value": "100000000000nhash"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "message",
         #      "attributes": [
         #        {
         #          "key": "sender",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "tx",
         #      "attributes": [
         #        {
         #          "key": "additionalfee",
         #          "value": "100000000000nhash"
         #        },
         #        {
         #          "key": "basefee",
         #          "value": "7620000000nhash"
         #        },
         #        {
         #          "key": "fee_payer",
         #          "value": "pb1rjjcdl5tx422krdd2qzpxauhqafcntanysle7g"
         #        }
         #      ]
         #    },
         #    {
         #      "type": "provenance.msgfees.v1.EventMsgFees",
         #      "attributes": [
         #        {
         #          "key": "msg_fees",
         #          "value": "[{\"msg_type\":\"/provenance.marker.v1.MsgAddMarkerRequest\",\"count\":\"1\",\"total\":\"100000000000nhash\",\"recipient\":\"\"}]"
         #        }
         #      ]
         #    }
         #  ]
         #}
    curl "https://api.provenance.io/cosmos/tx/v1beta1/txs/$line" | jq '.tx_response.events[].attributes[] | select(.key == "Y29kZV9pZA==") ' > code_ids.txt
done < txHashes.txt