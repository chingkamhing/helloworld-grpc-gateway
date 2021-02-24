#!/bin/bash
#
# Script to protoc generate all proto source files.
#

# either 0 argument
NUM_ARGS=0

# Function
SCRIPT_NAME=${0##*/}
Usage () {
	echo
	echo "Description:"
	echo "Script to protoc generate all proto source files."
	echo
	echo "Usage: $SCRIPT_NAME"
	echo "Options:"
	echo " -h                           This help message"
	echo
}

# Parse input argument(s)
while [ "${1:0:1}" == "-" ]; do
	OPT=${1:1:1}
	case "$OPT" in
	"h")
		Usage
		exit
		;;
	esac
	shift
done

if [ "$#" -ne "$NUM_ARGS" ]; then
    echo "Invalid parameter!"
	Usage
	exit 1
fi

# generate api grpc-gateway server
protoc -I ./proto -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out ./proto/api --go_opt paths=source_relative --go-grpc_out ./proto/api --go-grpc_opt paths=source_relative --swagger_out ./proto/api ./proto/api.proto
protoc -I ./proto -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out ./proto/api --go_opt paths=source_relative --go-grpc_out ./proto/api --go-grpc_opt paths=source_relative --grpc-gateway_out ./proto/api --grpc-gateway_opt paths=source_relative ./proto/api.proto
# generate helloworld grpc server
protoc -I ./proto --go_out ./proto/helloworld --go_opt paths=source_relative --go-grpc_out ./proto/helloworld --go-grpc_opt paths=source_relative ./proto/helloworld.proto
