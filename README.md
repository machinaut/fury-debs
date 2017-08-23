# fury-debs

Debian packages hosted on [Gemfury](https://gemfury.com):

 - [protobuf](https://gemfury.com/machinaut/deb:protobuf)
 - [grpc](https://gemfury.com/machinaut/deb:grpc)

This is a set of scripts to automate building debian packages.

Prebuilt packages are mostly an optimization for faster docker builds.

## Building and Uploading

To build and upload everything at once:

    make

See Makefiles in subdirectories for more.

## Using Packages

To use the debian package:

    apt-get update && apt-get install -y apt-transport-https
    echo "deb [trusted=yes] https://repo.fury.io/machinaut/ /" >> /etc/apt/sources.list.d/fury.list
    apt-get update && apt-get -y install grpc protobuf && ldconfig

## Reference

Heavily based on this blog post by Xan Manning:
https://xan-manning.co.uk/making-deb-packages-using-docker/
