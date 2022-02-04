#!/bin/sh
set -e

if [ -z "$NODE_ID" ]; then
	node_id=`hostname`
fi

hostname=`hostname -f`
if [ -z "$HTTP_ADDR_ADV" ]; then
      HTTP_ADV_ADDR=$hostname
fi
if [ -z "$RAFT_ADDR_ADV" ]; then
      RAFT_ADV_ADDR=$hostname
fi
if [ -z "$HTTP_ADV_ADDR_PORT" ]; then
      HTTP_ADV_ADDR_PORT=4001
fi
if [ -z "$RAFT_ADV_ADDR_PORT" ]; then
      RAFT_ADV_ADDR_PORT=4002
fi


rqlited_commands="/bin/rqlited -node-id $NODE_ID -http-addr 0.0.0.0:4001 -raft-addr 0.0.0.0:4002 -http-adv-addr $HTTP_ADV_ADDR:$HTTP_ADV_ADDR_PORT -raft-adv-addr $RAFT_ADV_ADDR:$RAFT_ADV_ADDR_PORT"
data_dir="/rqlite/file/data"

if [ "$1" = "rqlite" ]; then
	set -- $rqlited_commands $data_dir
elif [ "${1:0:1}" = '-' ]; then
	# User is passing some options, so merge them.
	set -- $rqlited_commands $@ $data_dir
fi

exec "$@"
