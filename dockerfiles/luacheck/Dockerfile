FROM woahbase/alpine-lua:5.4.8
RUN apk add --no-cache \
      curl \
      unzip \
      openssl \
      build-base \
    && luarocks install luacheck

ENTRYPOINT ["luacheck"]
