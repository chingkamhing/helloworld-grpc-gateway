#!/bin/bash

#
# Script to install various go libraries.
#

# either 0 argument
NUM_ARGS=0

# Function
SCRIPT_NAME=${0##*/}
Usage () {
	echo
	echo "Description:"
	echo "Script to install various go libraries."
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

# get protocol buffer libraries
# [20210131] somehow, fail to install the following protoc-gen-grpc-gateway v2; so, install latest protoc-gen-grpc-gateway instead
go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
go get -u google.golang.org/protobuf/cmd/protoc-gen-go
go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
