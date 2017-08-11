.PHONY: all clean deb upload

# Set FURY_USER and FURY_SECRET environment variables
FURY=https://$(FURY_SECRET)@push.fury.io/$(FURY_USER)/
TAG=protobuf_builder
PWD=$(shell pwd)

all: deb

clean:
	rm -rf build release

deb: clean
	docker build -t $(TAG) .
	mkdir -p build
	mkdir -p release
	docker run -v $(PWD)/build:/build -v $(PWD)/release:/release --rm $(TAG)

upload: deb
	debfile=$$(ls release/*.deb); curl -F package=@$$debfile $(FURY)
