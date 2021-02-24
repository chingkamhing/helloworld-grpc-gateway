#!/bin/bash
#
# Script to protoc generate all proto source files.
#

PROTO_DIR="proto"
OUTPUT_DIR="proto-lib"
GATEWAY="api"
SERVICES=( $GATEWAY "helloworld" )

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

# Generate proto files
GenerateProto () {
	local src_root_dir=$1
	local service=$2
	local output_root_dir=$3
	local src_dir="${src_root_dir}/${service}"
	local output_dir="${output_root_dir}/${service}"
	echo "Generating proto files for service \"$service\""
	[ -d $output_dir ] || mkdir -p $output_dir
	if [ "$service" == "$GATEWAY" ]; then
		local option_gateway="--grpc-gateway_out ${output_root_dir} --grpc-gateway_opt paths=source_relative --swagger_out ${output_root_dir}"
	fi
    for file in *.proto; do
		protoc -I ${src_root_dir} -I ${GOPATH}/src/github.com/googleapis/googleapis \
			--go_out ${output_root_dir} --go_opt paths=source_relative \
			--go-grpc_out ${output_root_dir} --go-grpc_opt paths=source_relative \
			${option_gateway} \
			${src_dir}/${file}
	done
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

# generate services proto files
for service in "${SERVICES[@]}"; do
	GenerateProto $PROTO_DIR $service $OUTPUT_DIR
done
