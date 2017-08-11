FROM ubuntu:16.04
# reference: https://xan-manning.co.uk/making-deb-packages-using-docker/

VOLUME /build
VOLUME /release

# Install build dependencies
RUN apt-get update && apt-get -y install \
    build-essential \
    devscripts \
    fakeroot \
    debhelper \
    automake \
    autotools-dev \
    pkg-config \
    git \
    ca-certificates \
    --no-install-recommends

# Install application dependencies
RUN apt-get update && apt-get -y install \
    build-essential \
    autoconf \
    libtool \
    libgflags-dev \
    libgtest-dev \
    clang \
    libc++-dev \
    --no-install-recommends

# Clone grpc
RUN git clone https://github.com/grpc/grpc /src
WORKDIR /src
RUN git fetch
RUN git submodule update --init

# Import resources
COPY ./resources /src/resources
COPY ./entrypoint.sh /entrypoint.sh

# Make Executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
