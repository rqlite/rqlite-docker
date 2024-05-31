# About this repo
> This repo is obsolete. Docker images are now created via GitHub actions in the [rqlite repository](https://github.com/rqlite/rqlite).

[![Google Group](https://img.shields.io/badge/Google%20Group--blue.svg)](https://groups.google.com/group/rqlite) [![Slack](https://img.shields.io/badge/Slack--purple.svg)](https://www.philipotoole.com/join-rqlite-slack)

This is the Git repo for the [rqlite](https://rqlite.io) Docker [image](https://hub.docker.com/r/rqlite/rqlite/). Check the Dockerfile within each directory to learn which [rqlite release](https://github.com/rqlite/rqlite/releases), and architecture, the Docker image uses. If you build your own rqlite container, you may need to use a different release than that referenced in the Dockerfile.

## Downloading latest image

    docker pull rqlite/rqlite

## Starting a single node

    docker run rqlite/rqlite

This will start a single node, connected to the default `bridge` network. The HTTP API will be available at `http://$IP:4001`. `$IP` is the address Docker assigns to your rqlite container, and will be displayed in the rqlite logs. For convenience you might like to make rqlite available on localhost by passing `-p4001:4001` to the `run` command.

    docker run -p4001:4001 rqlite/rqlite

### Passing extra options to rqlite
rqlite supports many options, allowing you to control its behavior. To set an option simply append it your launch command. For example, to explicitly set the path to the SQLite database file:

    docker run rqlite/rqlite -on-disk-path=/root/mydb.sqlite3

You can see the full set of options via:

    docker run rqlite/rqlite -help

### Clustering

    docker run rqlite/rqlite -join $IP:4002

where `$IP` is the Raft IP address of the node you wish to join.

See the [clustering guide](https://rqlite.io/docs/clustering/) for more details on creating and managing rqlite clusters.
