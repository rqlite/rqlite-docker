#!/bin/sh

contains() {
	key=$1
	shift
	for i in "$@"
	do
		if [[ $i == $key* ]]; then
			return 1
		fi
	done
	return 0
}

DEFAULT_NODE_ID=`hostname`
DEFAULT_ADV_ADDRESS=`hostname -f`

contains "-http-addr" "$@"
if [ $? -eq 0 ]; then
	if [ -z "$HTTP_ADDR" ]; then
		HTTP_ADDR="0.0.0.0:4001"
	fi
	http_addr="-http-addr $HTTP_ADDR"
fi

contains "-http-addr-adv" "$@"
if [ $? -eq 0 ]; then
	if [ -z "$HTTP_ADV_ADDR" ]; then
		HTTP_ADV_ADDR=$DEFAULT_ADV_ADDRESS:4001
	fi
	http_adv_addr="-http-adv-addr $HTTP_ADV_ADDR"
fi

contains "-raft-adv" "$@"
if [ $? -eq 0 ]; then
	if [ -z "$RAFT_ADDR" ]; then
		RAFT_ADDR="0.0.0.0:4002"
	fi
	raft_addr="-raft-addr $RAFT_ADDR"
fi

contains "-raft-adv-addr" "$@"
if [ $? -eq 0 ]; then
	if [ -z "$RAFT_ADV_ADDR" ]; then
		RAFT_ADV_ADDR=$DEFAULT_ADV_ADDRESS:4002
	fi
	raft_adv_addr="-raft-adv-addr $RAFT_ADV_ADDR"
fi

contains "-node-id" "$@"
if [ $? -eq 0 ]; then
	if [ -z "$NODE_ID" ]; then
		NODE_ID="$DEFAULT_NODE_ID"
	fi
	node_id="-node-id $NODE_ID"
fi

RQLITED=/bin/rqlited
rqlited_commands="$RQLITED $node_id $http_addr $http_adv_addr $raft_addr $raft_adv_addr"
data_dir="/rqlite/file/data"

if [ "$1" = "rqlite" ]; then
        set -- $rqlited_commands $data_dir
elif [ "${1:0:1}" = '-' ]; then
        # User is passing some options, so merge them.
        set -- $rqlited_commands $@ $data_dir
fi

exec "$@"
