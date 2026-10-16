FROM debian:bookworm-slim AS bin

ENV RELEASES_URL=https://github.com/protocolbuffers/protobuf/releases/download
ARG VERSION=21.9
ARG TARGETARCH

WORKDIR /tmp/protoc

RUN apt-get update -y \
      && apt-get install -y wget unzip \
      && case "${TARGETARCH}" in \
           amd64) ARCH=x86_64 ;; \
           arm64) ARCH=aarch_64 ;; \
           *) echo "unsupported arch: ${TARGETARCH}" >&2; exit 1 ;; \
         esac \
      && wget ${RELEASES_URL}/v${VERSION}/protoc-${VERSION}-linux-${ARCH}.zip -O protoc.zip \
      && unzip protoc.zip

FROM golang:1.19-bookworm

WORKDIR /protoc
COPY --from=bin /tmp/protoc/bin/protoc /usr/local/bin/protoc

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

ENTRYPOINT ["/usr/local/bin/protoc"]
