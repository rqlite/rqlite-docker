# About this repo 
[![Google Group](https://img.shields.io/badge/Google%20Group--blue.svg)](https://groups.google.com/group/rqlite) [![Slack](https://img.shields.io/badge/Slack--purple.svg)](https://www.philipotoole.com/join-rqlite-slack)

This is the Git repo for the [rqlite](https://rqlite.io) Docker [image](https://hub.docker.com/r/rqlite/rqlite/).

## Downloading latest image

    docker pull rqlite/rqlite

## Starting a single node

    docker run rqlite/rqlite

This will start a single node, connected to the default `bridge` network. The HTTP API will be available at `http://$IP:4001`. `$IP` is the address Docker assigns to your rqlite container, and will be displayed in the rqlite logs.

### Passing extra options to rqlite
rqlite supports many options, allowing you to control its behavior. To set an option simply append it your launch command. For example, to enable on-disk mode:

    docker run rqlite/rqlite -on-disk

You can see the full set of options via:

    docker run rqlite/rqlite -help

### Clustering

    docker run rqlite/rqlite -join $IP:4001

where `$IP` is the HTTP API IP address of the node you wish to join.

See the [rqlite Docker page](https://hub.docker.com/r/rqlite/rqlite) for more details.
