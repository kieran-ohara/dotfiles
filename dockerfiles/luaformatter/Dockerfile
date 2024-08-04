FROM woahbase/alpine-lua
RUN apk add --no-cache \
      curl \
      unzip \
      openssl \
      build-base

RUN apk add --no-cache cmake

RUN luarocks install --server=https://luarocks.org/dev luaformatter

ENTRYPOINT ["lua-format"]
