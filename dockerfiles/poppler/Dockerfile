FROM alpine:latest

# poppler-data supplies encoding/CMap data; fontconfig + the Liberation fonts
# give poppler metric-compatible substitutes for the standard base-14 fonts
# (Helvetica/Times/Courier), without which rasterising most real PDFs fails.
RUN apk add --no-cache \
    poppler-utils \
    poppler-data \
    fontconfig \
    ttf-liberation

WORKDIR /workdir
