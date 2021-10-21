#!/bin/sh
set -e

ip=`hostname -i`
if [ -z "$HTTP_ADDR_ADV_IP" ]; then
      HTTP_ADV_ADDR_IP=$ip
fi
if [ -z "$RAFT_ADDR_ADV_IP" ]; then
      RAFT_ADV_ADDR_IP=$ip
fi
if [ -z "$HTTP_ADV_ADDR_PORT" ]; then
      HTTP_ADV_ADDR_PORT=4001
fi
if [ -z "$RAFT_ADV_ADDR_PORT" ]; then
      RAFT_ADV_ADDR_PORT=4002
fi

rqlited_commands="/bin/rqlited -http-addr 0.0.0.0:4001 -raft-addr 0.0.0.0:4002 -http-adv-addr $HTTP_ADV_ADDR_IP:$HTTP_ADV_ADDR_PORT -raft-adv-addr $RAFT_ADV_ADDR_IP:$RAFT_ADV_ADDR_PORT"
data_dir="/rqlite/file/data"

if [ "$1" = "rqlite" ]; then
	set -- $rqlited_commands $data_dir
elif [ "${1:0:1}" = '-' ]; then
	# User is passing some options, so merge them.
	set -- $rqlited_commands $@ $data_dir
fi

exec "$@"
