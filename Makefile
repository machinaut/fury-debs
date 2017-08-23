.PHONY: all protobuf grpc

all: protobuf grpc

grpc:
	make -C $@ upload

protobuf:
	make -C $@ upload
