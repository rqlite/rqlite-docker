# About this repo 
[![Google Group](https://img.shields.io/badge/Google%20Group--blue.svg)](https://groups.google.com/group/rqlite)
This is the Git repo for the [rqlite](https://github.com/rqlite/rqlite) Docker [image](https://hub.docker.com/r/rqlite/rqlite/).


## rqlite
rqlite is a distributed relational database, which uses SQLite as its storage engine. rqlite uses Raft to achieve consensus across all the instances of the SQLite databases, ensuring that every change made to the system is made to a quorum of SQLite databases, or none at all. It also gracefully handles leader elections, and tolerates failures of machines, including the leader. rqlite is available for Linux, OSX, and Microsoft Windows.

## Getting rqlite
You can download the latest image via:
```
    docker pull rqlite/rqlite
```
Then start up a single node like so:
```
    docker run -p 4001:4001 -p4002:4002 rqlite/rqlite
```

Instructions for clustering via Docker are forthcoming, but it should not be difficult for people with experience with Docker and networking.
