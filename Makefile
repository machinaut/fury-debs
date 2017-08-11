.PHONY: all protobuf grpc

all: upload

grpc:
	make -C $@ upload

protobuf:
	make -C $@ upload
