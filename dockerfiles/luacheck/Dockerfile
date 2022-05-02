FROM woahbase/alpine-lua
RUN apk add --no-cache \
      curl \
      unzip \
      openssl \
      build-base \
    && luarocks install luacheck

ENTRYPOINT ["luacheck"]
