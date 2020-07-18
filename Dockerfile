FROM ubuntu:latest

ARG DEFAULT_NODE_VERSION=14.5.0

WORKDIR /root
COPY docker-entrypoint.sh .

# Install package and nodenv https://github.com/nodenv/nodenv#basic-github-checkout
RUN apt-get update && apt-get install -y \
        git \
        curl \
        build-essential \
    && git clone https://github.com/nodenv/nodenv.git ~/.nodenv \
    && cd ~/.nodenv && src/configure && make -C src

# Add nodenv command $PATH
ENV PATH ~/.nodenv/bin:$PATH
ENV PATH ~/.nodenv/shims:$PATH

# Install node-build As a nodenv plugin https://github.com/nodenv/node-build#installation
RUN eval "$(nodenv init -)" \
    && mkdir -p "$(nodenv root)"/plugins \
    && git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# Install "DEFAULT_NODE_VERSION" node
RUN eval "$(nodenv init -)" \
    && nodenv install $DEFAULT_NODE_VERSION \
    && nodenv global $DEFAULT_NODE_VERSION

ENTRYPOINT [ "bash", "docker-entrypoint.sh" ]
CMD [ "nodenv" ]