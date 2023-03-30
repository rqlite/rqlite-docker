#!/bin/sh

contains() {
    local key=$1
    shift
    for i in "$@"
    do
        if [[ $i == "$key"* ]]; then
            return 1
        fi
    done
    return 0
}

set_option() {
    local contains_key=$1
    local env_var_name=$2
    local default_value=$3
    local option_name=$4

    contains "$contains_key" "$@"
    if [ $? -eq 0 ]; then
        if [ -z "${!env_var_name}" ]; then
            eval "$env_var_name=\"$default_value\""
        fi
        echo "$option_name ${!env_var_name}"
    else
        echo ""
    fi
}

DEFAULT_NODE_ID=$(hostname)
DEFAULT_ADV_ADDRESS=$(hostname -f)

http_addr=$(set_option "-http-addr" "HTTP_ADDR" "0.0.0.0:4001" "-http-addr")
http_adv_addr=$(set_option "-http-adv-addr" "HTTP_ADV_ADDR" "$DEFAULT_ADV_ADDRESS:4001" "-http-adv-addr")
raft_addr=$(set_option "-raft-addr" "RAFT_ADDR" "0.0.0.0:4002" "-raft-addr")
raft_adv_addr=$(set_option "-raft-adv-addr" "RAFT_ADV_ADDR" "$DEFAULT_ADV_ADDRESS:4002" "-raft-adv-addr")
node_id=$(set_option "-node-id" "NODE_ID" "$DEFAULT_NODE_ID" "-node-id")

if [ -z "$DATA_DIR" ]; then
    DATA_DIR="/rqlite/file/data"
fi

# When running on Kubernetes, delay a small time so DNS records
# are configured across the cluster when this rqlited comes up. Because
# rqlite does node-discovery using a headless service, it must have
# accurate DNS records. If the Pods addresses are not in the records,
# the DNS lookup will result in an error, and the Kubernetes system will
# cache this failure for (by default) 30 seconds. So this delay
# actually means getting to "ready" is quicker.
#
# This is kind of a hack. If anyone knows a better way file
# a GitHub issue at https://github.com/rqlite/rqlite-docker.
if [ -n "$KUBERNETES_SERVICE_HOST" ] && [ -z "$START_DELAY" ]; then
    START_DELAY=5
fi

if [ -n "$START_DELAY" ]; then
    sleep "$START_DELAY"
fi

RQLITED=/bin/rqlited
rqlited_commands="$RQLITED $node_id $http_addr $http_adv_addr $raft_addr $raft_adv_addr"
data_dir="$DATA_DIR"

if [ "$1" = "rqlite" ]; then
    set -- $rqlited_commands $data_dir
elif [ "${1:0:1}" = '-' ]; then
    set -- $rqlited_commands "$@" $data_dir
fi

exec "$@"
