#!/bin/bash

# env
. ./params.sh

# params
deviceId=xxxxxxxx # Air Conditioner
COMMAND=${1} # turnOn or turnOff

# generate SIGN
NONCE=$(uuidgen)
TIMESTAMP=$(date +%s%3N) # 13桁(ミリ秒まで含む)
SIGN=$(python3 sign.py ${TOKEN} ${SECRET} ${NONCE} ${TIMESTAMP})

# request
curl -s --request POST \
--url https://api.switch-bot.com/v1.1/devices/${deviceId}/commands \
--header "Authorization: ${TOKEN}" \
--header "sign: ${SIGN}" \
--header "nonce: ${NONCE}" \
--header "t: ${TIMESTAMP}" \
--header "Content-Type: application/json" \
--data "{\"command\": \"${COMMAND}\",\"commandType\": \"command\"}" | jq .
