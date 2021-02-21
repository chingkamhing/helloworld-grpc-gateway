.PHONY: build
build:
	go build -o helloworld ./*.go

.PHONY: proto
proto:
	# generate helloworld grpc server
	protoc -I ./proto --go_out ./proto/helloworld --go_opt paths=source_relative --go-grpc_out ./proto/helloworld --go-grpc_opt paths=source_relative ./proto/helloworld.proto
	# generate api grpc-gateway server
	protoc -I ./proto -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out ./proto/api --go_opt paths=source_relative --go-grpc_out ./proto/api --go-grpc_opt paths=source_relative --grpc-gateway_out ./proto/api --grpc-gateway_opt paths=source_relative ./proto/api.proto

.PHONY: all
all: proto build

.PHONY: install
install:
	# [20210131] somehow, fail to install the following protoc-gen-grpc-gateway v2; so, install latest protoc-gen-grpc-gateway instead
	go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
	# go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	go get google.golang.org/protobuf/cmd/protoc-gen-go
	go get google.golang.org/grpc/cmd/protoc-gen-go-grpc

.PHONY: clean
clean:
	rm -rf proto/helloworld
	rm -rf proto/api
	rm -f helloworld
