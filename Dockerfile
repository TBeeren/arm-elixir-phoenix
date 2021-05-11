# Cloned and build from erlang image build for arm processors.
FROM bitwalker/alpine-elixir:latest
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
