FROM ubuntu:xenial
MAINTAINER Philip O'Toole <philip.otoole@yahoo.com>

ENV RQLITE_VERSION=5.10.1

RUN apt-get update && \
    apt-get install -y curl && \
    curl -L https://github.com/rqlite/rqlite/releases/download/v${RQLITE_VERSION}/rqlite-v${RQLITE_VERSION}-linux-amd64.tar.gz -o rqlite-v${RQLITE_VERSION}-linux-amd64.tar.gz && \
    tar xvfz rqlite-v${RQLITE_VERSION}-linux-amd64.tar.gz && \
    cp rqlite-v${RQLITE_VERSION}-linux-amd64/rqlited /bin && \
    cp rqlite-v${RQLITE_VERSION}-linux-amd64/rqlite /bin && \
    rm -fr rqlite-v${RQLITE_VERSION}-linux-amd64 rqlite-v${RQLITE_VERSION}-linux-amd64.tar.gz && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /rqlite/file

VOLUME /rqlite/file

EXPOSE 4001 4002

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rqlited", "-http-addr", "0.0.0.0:4001", "-raft-addr", "0.0.0.0:4002", "/rqlite/file/data"]
