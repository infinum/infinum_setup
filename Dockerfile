FROM debian:trixie-slim@sha256:c2880112cc5c61e1200c26f106e4123627b49726375eb5846313da9cca117337

ARG RUBY_VERSION=2.6.10
ARG OPENSSL_VERSION=1.1.1u

ENV DEBIAN_FRONTEND=noninteractive \
    PATH=/usr/local/bin:/usr/local/sbin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    wget \
    curl \
    ca-certificates \
    gnupg \
    xz-utils \
    libreadline-dev \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    libyaml-dev \
    libgdbm-dev \
    libncurses-dev \
    autoconf \
    bison \
    pkg-config \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

RUN wget -q https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
    && tar xzf openssl-${OPENSSL_VERSION}.tar.gz \
    && cd openssl-${OPENSSL_VERSION} \
    && ./config --prefix=/usr/local/openssl-1.1 no-shared no-ssl3 no-comp enable-ec_nistp_64_gcc_128 -fPIC \
    && make -j"$(nproc)" \
    && make install_sw \
    && cd .. \
    && rm -rf openssl-${OPENSSL_VERSION}*

RUN wget -q https://cache.ruby-lang.org/pub/ruby/2.6/ruby-${RUBY_VERSION}.tar.gz \
    && tar xzf ruby-${RUBY_VERSION}.tar.gz \
    && cd ruby-${RUBY_VERSION} \
    && export CPPFLAGS="-I/usr/local/openssl-1.1/include" \
    && export LDFLAGS="-L/usr/local/openssl-1.1/lib" \
    && ./configure --prefix=/usr/local \
                  --with-openssl-dir=/usr/local/openssl-1.1 \
                  --disable-install-doc \
    && make -j"$(nproc)" \
    && make install \
    && cd .. \
    && rm -rf ruby-${RUBY_VERSION}*

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    libreadline8 \
    zlib1g \
    libgdbm6 \
    libncurses6 \
    libffi8 \
    && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/openssl-1.1/lib:$LD_LIBRARY_PATH
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR=/etc/ssl/certs

ADD infinum_setup.gemspec Gemfile ./
ADD lib/infinum_setup/version.rb ./lib/infinum_setup/version.rb
RUN bundle install
