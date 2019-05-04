FROM golang:1.9-alpine3.6 as go

# Setup the Environment
ENV GOPATH=/root/go \
    PATH=${PATH}:/usr/local/go/bin:/root/go/bin \
    VERSION_TAG=v4.5.0 \
    LANG=C.UTF-8

# Install Build Deps
RUN apk add --no-cache git bash gcc alpine-sdk build-base

# Build the rqlite binary
RUN mkdir -p /root/dist ${GOPATH} \
    && cd ${GOPATH} \
    && mkdir -p src/github.com/rqlite \
    && cd src/github.com/rqlite \
    && git clone https://github.com/rqlite/rqlite \
    && cd rqlite \
    && git checkout -b alpine-${VERSION_TAG} tags/${VERSION_TAG} \
    && branch=`git rev-parse --abbrev-ref HEAD` \
    && commit=`git rev-parse HEAD` \
    && buildtime=`date +%Y-%m-%dT%T%z` \
    && go get -d ./... \
    && go install -ldflags="-X main.version=${VERSION_TAG} -X main.branch=$branch -X main.commit=$commit -X main.buildtime=$buildtime" ./...

# Real Build Now
FROM alpine:3.6

# Add real maintainer
LABEL MAINTAINER="Philip O'Toole <philip.otoole@yahoo.com>"

# Setup the Environment
ENV GOPATH=/root/go \
    PATH=${PATH}:/usr/local/go/bin:/root/go/bin \
    LANG=C.UTF-8 \
    RQLITE_VERSION=4.5.0

# Upgrade (just in case there are security updates)
RUN apk update -v \
    && apk add bash \
    && apk upgrade -v --no-cache

# Copy Assets from Go build
COPY --from=go /root/go/bin/rqlited /bin/rqlited
COPY --from=go /root/go/bin/rqlite /bin/rqlite
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh

# Create Volume
RUN mkdir -p /rqlite/file
VOLUME /rqlite/file

# Expose Ports
EXPOSE 4001 4002

# ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD ["rqlited", "-http-addr", "0.0.0.0:4001", "-raft-addr", "0.0.0.0:4002", "/rqlite/file/data"]
