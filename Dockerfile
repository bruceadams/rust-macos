FROM rust

RUN apt-get update --yes \
    && apt-get install --yes --no-install-recommends \
    clang \
    cmake \
    libmpc-dev \
    libmpfr-dev \
    rsync \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/tpoechtrager/osxcross \
    && cd osxcross/tarballs \
    && curl -O https://s3.dockerproject.org/darwin/v2/MacOSX10.10.sdk.tar.xz \
    && cd .. \
    && UNATTENDED=yes OSX_VERSION_MIN=10.10 ./build.sh \
    && rsync -a target/* /usr/local \
    && cd .. \
    && rm -rf osxcross

ENV CC=o64-clang
ENV CXX=o64-clang++

RUN rustup target add x86_64-apple-darwin
RUN mkdir --mode=777 /build
RUN useradd rust
USER rust
COPY cargo-config.toml /usr/local/cargo/config
WORKDIR /build
CMD [ "cargo", "build", "--target", "x86_64-apple-darwin", "--release" ]
