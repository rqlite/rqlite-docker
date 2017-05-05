#!/bin/bash

# User wants to override options, so merge with defaults.
if [ "${1:0:1}" = '-' ]; then
        set -- rqlited -http 0.0.0.0:4001 -raft 0.0.0.0:4002 $@ /rqlite/file/data
fi

exec "$@"
