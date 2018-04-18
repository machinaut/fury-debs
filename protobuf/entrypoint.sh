#!/bin/bash
# reference: https://xan-manning.co.uk/making-deb-packages-using-docker/
set -e

# Clear out the /build and /release directory
rm -rf /build/*
rm -rf /release/*

# Re-pull the repository
git fetch && \
    BUILD_VERSION=$(cat VERSION) && \
    git checkout ${BUILD_VERSION} && \
    git submodule update --init

# Configure, make, make install
./autogen.sh
mkdir -p /build/usr/local
./configure --prefix=/build/usr/local
make
make check
fakeroot make install

# Get the Install Size
INSTALL_SIZE=$(du -s /build/usr | awk '{ print $1 }')

# Make DEBIAN directory in /build
mkdir -p /build/DEBIAN

# Copy the control file from resources
cp /src/resources/control.in /build/DEBIAN/control

# Fill in the information in the control file
sed -i "s/__VERSION__/${BUILD_VERSION:1}/g" /build/DEBIAN/control
sed -i "s/__FILESIZE__/${INSTALL_SIZE}/g" /build/DEBIAN/control

# Build our Debian package
fakeroot dpkg-deb -b "/build"

# Move it to release
mv /build.deb /release/protobuf-${BUILD_VERSION}-amd64.deb
