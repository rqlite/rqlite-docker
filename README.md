# About this repo
This is the Git repo for the [rqlite](https://github.com/rqlite/rqlite) Docker image.

## rqlite
rqlite is a distributed relational database, which uses SQLite as its storage engine. rqlite uses Raft to achieve consensus across all the instances of the SQLite databases, ensuring that every change made to the system is made to a quorum of SQLite databases, or none at all. It also gracefully handles leader elections, and tolerates failures of machines, including the leader. rqlite is available for Linux, OSX, and Microsoft Windows.
