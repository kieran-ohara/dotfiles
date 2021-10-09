FROM alpine:3.9

RUN apk add --update --nocache nodejs npm \
    && rm -rf /var/cache/apk/*

RUN apk add --update --nocache \
    graphviz font-bitstream-type1 ghostscript-fonts \
    httpie \
    gnupg \
    && rm -rf /var/cache/apk/*

RUN npm install -g \
    tldr
