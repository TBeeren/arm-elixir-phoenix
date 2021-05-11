# Cloned and build from erlang image build for arm processors.
FROM hexpm/elixir:1.10.2-erlang-22.2.8-alpine-3.11.3
MAINTAINER Tim Beeren <tim.beerenn<at>gmail.com>

WORKDIR /tmp/elixir-build

RUN \
    apk --no-cache --update upgrade && \
    apk add --no-cache --update --virtual .elixir-build \
    make && \
    apk add --no-cache --update \
    git && \
    git clone https://github.com/elixir-lang/elixir --depth 1 --branch v1.11.4 && \
    cd elixir && \
    make && make install && \
    mix local.hex --force && \
    mix local.rebar --force && \
    cd $HOME && \
    rm -rf /tmp/elixir-build && \
    apk del .elixir-build

WORKDIR ${HOME}

CMD ["/bin/sh"]
