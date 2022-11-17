FROM debian:bullseye-slim as bin

ENV RELEASES_URL=https://github.com/protocolbuffers/protobuf/releases/download
ARG VERSION=21.9

WORKDIR /tmp/protoc

RUN apt-get update -y \
      && apt-get install -y wget unzip \
      && wget ${RELEASES_URL}/v${VERSION}/protoc-${VERSION}-linux-aarch_64.zip -O protoc.zip \
      && unzip protoc.zip

FROM golang:1.19-bullseye

WORKDIR /protoc
COPY --from=bin /tmp/protoc/bin/protoc /usr/local/bin/protoc

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

ENTRYPOINT ["/usr/local/bin/protoc"]
