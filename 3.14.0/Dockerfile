FROM ubuntu:yakkety
MAINTAINER Philip O'Toole <philip.otoole@yahoo.com>

ENV RQLITE_VERSION=3.14.0

RUN apt-get update && \
    apt-get install -y curl && \
    curl -L https://github.com/rqlite/rqlite/releases/download/v${RQLITE_VERSION}/rqlited-v${RQLITE_VERSION}-linux-amd64.tar.gz -o rqlited-v${RQLITE_VERSION}-linux-amd64.tar.gz && \
    tar xvfz rqlited-v${RQLITE_VERSION}-linux-amd64.tar.gz && \
    cp rqlited-v${RQLITE_VERSION}-linux-amd64/rqlited /bin

RUN mkdir -p /rqlite/file

VOLUME /rqlite/file

EXPOSE 4001 4002

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rqlited", "-http", "0.0.0.0:4001", "-raft", "0.0.0.0:4002", "/rqlite/file/data"]
