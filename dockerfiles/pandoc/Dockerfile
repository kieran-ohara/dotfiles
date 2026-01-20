# Use a base image with a minimal Linux distribution
FROM alpine:latest

# Install Pandoc and its dependencies
RUN apk add --no-cache \
    pandoc \
    texlive \
    texmf-dist-latexextra \
    texmf-dist-fontsrecommended \
    nodejs \
    npm

# Install Reveal.js
RUN npm install -g reveal.js

# Set the working directory
WORKDIR /data

# Set Pandoc as the entrypoint with default Reveal.js options
ENTRYPOINT ["pandoc", "--variable", "revealjs-url=https://unpkg.com/reveal.js"]

# Set the default command (can be overridden)
CMD ["--help"]
