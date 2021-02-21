.PHONY: build
build:
	go build -o api ./cmd/api/*.go
	go build -o helloworld ./cmd/server/*.go

.PHONY: proto
proto:
	# generate api grpc-gateway server
	protoc -I ./proto -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out ./proto/api --go_opt paths=source_relative --go-grpc_out ./proto/api --go-grpc_opt paths=source_relative --grpc-gateway_out ./proto/api --grpc-gateway_opt paths=source_relative ./proto/api.proto
	# generate helloworld grpc server
	protoc -I ./proto --go_out ./proto/helloworld --go_opt paths=source_relative --go-grpc_out ./proto/helloworld --go-grpc_opt paths=source_relative ./proto/helloworld.proto

.PHONY: all
all: proto build

.PHONY: install
install:
	./script/install-libraries.sh

.PHONY: clean
clean:
	rm -rf proto/helloworld/*
	rm -rf proto/api/*
	rm -f helloworld
