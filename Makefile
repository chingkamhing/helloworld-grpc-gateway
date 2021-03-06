.PHONY: build
build:
	go build -o api ./cmd/api/*.go
	go build -o helloworld ./cmd/server/*.go

.PHONY: proto
proto:
	./script/gen-proto.sh

.PHONY: all
all: proto build

.PHONY: install
install:
	./script/install-proto.sh

.PHONY: clean
clean:
	rm -rf proto-lib/api/*
	rm -rf proto-lib/helloworld/*
	rm -f api
	rm -f helloworld
