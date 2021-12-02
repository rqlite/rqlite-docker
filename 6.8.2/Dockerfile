FROM alpine:latest
MAINTAINER Philip O'Toole <philip.otoole@yahoo.com>

ENV RQLITE_VERSION=6.8.2

RUN apk update && \
    apk --no-cache add curl tar && \
    curl -L https://github.com/rqlite/rqlite/releases/download/v${RQLITE_VERSION}/rqlite-v${RQLITE_VERSION}-linux-amd64-musl.tar.gz -o rqlite-v${RQLITE_VERSION}-linux-amd64-musl.tar.gz && \
    tar xvfz rqlite-v${RQLITE_VERSION}-linux-amd64-musl.tar.gz && \
    cp rqlite-v${RQLITE_VERSION}-linux-amd64-musl/rqlited /bin && \
    cp rqlite-v${RQLITE_VERSION}-linux-amd64-musl/rqlite /bin && \
    rm -fr rqlite-v${RQLITE_VERSION}-linux-amd64-musl rqlite-v${RQLITE_VERSION}-linux-amd64-musl.tar.gz && \
    apk del curl tar

RUN mkdir -p /rqlite/file

VOLUME /rqlite/file

EXPOSE 4001 4002

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rqlite"]
