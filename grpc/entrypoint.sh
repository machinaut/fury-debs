#!/bin/bash
# reference: https://xan-manning.co.uk/making-deb-packages-using-docker/

# Clear out the /build and /release directory
rm -rf /build/*
rm -rf /release/*

# Re-pull the repository
git fetch && \
    BUILD_VERSION=$(git tag | sort -r | head -1) && \
    git checkout ${BUILD_VERSION} && \
    git submodule update --init

# Configure, make, make install
make
mkdir -p /build/usr
mkdir -p /build/usr/local
fakeroot make prefix=/build/usr/local install

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
mv /build.deb /release/grpc-${BUILD_VERSION}-amd64.deb
