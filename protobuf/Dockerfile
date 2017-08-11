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
    autoconf \
    automake \
    libtool \
    curl \
    make \
    g++ \
    unzip \
    --no-install-recommends

# Clone git repo
RUN git clone https://github.com/google/protobuf /src
WORKDIR /src
RUN git fetch
RUN git submodule update --init --recursive

# Import resources
COPY ./resources /src/resources
COPY ./entrypoint.sh /entrypoint.sh

# Make Executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
