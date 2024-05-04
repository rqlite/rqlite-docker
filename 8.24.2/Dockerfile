
FROM alpine:latest
MAINTAINER Philip O'Toole <philip.otoole@yahoo.com>

RUN apk update &&     apk --no-cache add curl tar &&     curl -L https://github.com/rqlite/rqlite/releases/download/v8.24.2/rqlite-v8.24.2-linux-amd64-musl.tar.gz -o rqlite-v8.24.2-linux-amd64-musl.tar.gz &&     tar xvfz rqlite-v8.24.2-linux-amd64-musl.tar.gz &&     cp rqlite-v8.24.2-linux-amd64-musl/rqlited /bin &&     cp rqlite-v8.24.2-linux-amd64-musl/rqlite /bin &&     rm -fr rqlite-v8.24.2-linux-amd64-musl rqlite-v8.24.2-linux-amd64-musl.tar.gz &&     apk del curl tar

RUN mkdir -p /rqlite/file

VOLUME /rqlite/file

EXPOSE 4001 4002

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rqlite"]

