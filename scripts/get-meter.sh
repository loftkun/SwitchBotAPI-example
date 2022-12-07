#!/bin/bash

# env
. ./params.sh

# params
deviceId=xxxxxxxx

# generate SIGN
NONCE=$(uuidgen)
TIMESTAMP=$(date +%s%3N) # 13桁(ミリ秒まで含む)
SIGN=$(python3 sign.py ${TOKEN} ${SECRET} ${NONCE} ${TIMESTAMP})

# request
curl -s --request GET \
--url https://api.switch-bot.com/v1.1/devices/${deviceId}/status \
--header "Authorization: ${TOKEN}" \
--header "sign: ${SIGN}" \
--header "nonce: ${NONCE}" \
--header "t: ${TIMESTAMP}" \
| jq -r '.body | "温度は" + (.temperature|tostring) + "℃
" + "\n湿度は" + (.humidity|tostring) + "％です！"'

