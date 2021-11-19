#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
EXEC_CONF="$SCRIPT_DIR/config/execution.config.json"

set -o allexport
source $WALLET_CONF
set +o allexport

WALLET_ADR=$CUSTOM_TEMPLATE
if [[ -z "$WALLET_ADR" ]]; then
  exit 1
fi

NUM=$(echo "{$CUSTOM_USER_CONFIG}" | jq '[. | keys[] | select(contains("miner"))] | length')

# MINER EXECUTION CONFIG
jq -n \
--arg wallet $WALLET_ADR \
--arg num $NUM \
--argjson config "{$CUSTOM_USER_CONFIG}" \
'{"type":"cuda", "wallet": $wallet, "num": $num, $config}' \
> $EXEC_CONF

exit 0