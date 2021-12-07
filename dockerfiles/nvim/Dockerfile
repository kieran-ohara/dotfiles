# Treesitter Shared Objects
FROM rust:bullseye AS treesitter
RUN apt-get update && apt-get install -y \
        git \
        jq \
        nodejs \
        build-essential
RUN git clone https://github.com/tree-sitter/tree-sitter.git \
        --branch v0.20.1
RUN cd tree-sitter \
        && cargo build \
        && cargo install tree-sitter-cli

COPY config/nvim/parser /parser
COPY config/nvim/pack/treesitter/start/nvim-treesitter/lockfile.json \
    /nvim/pack/treesitter/start/nvim-treesitter/lockfile.json

RUN cd /parser && ./build-parsers.sh

# Editor Environment
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y \
        neovim \
        git \
        nodejs \
        npm \
        sudo \
    && npm install -g \
        eslint_d \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y build-essential npm \
    && apt -y autoremove

COPY dockerfiles/nvim/etc/sudoers.d/kieran /etc/sudoers.d/kieran

ENV HOME /Users/kieran
ENV XDG_CACHE_HOME $HOME/.cache
ENV XDG_CONFIG_HOME $HOME/.config

RUN adduser --home $HOME --gecos "" --disabled-password kieran
WORKDIR $HOME
USER kieran

RUN mkdir -p \
    $XDG_CACHE_HOME/vim/backupfiles \
    $XDG_CACHE_HOME/vim/swapfiles \
    $XDG_CACHE_HOME/vim/undodir

COPY config/vim/vimrc $HOME/.vimrc
COPY config/vim $XDG_CONFIG_HOME/vim
COPY config/nvim $XDG_CONFIG_HOME/nvim
COPY --from=treesitter /parser/*.so .config/nvim/parser
COPY config/git $XDG_CONFIG_HOME/git

CMD ["nvim"]
