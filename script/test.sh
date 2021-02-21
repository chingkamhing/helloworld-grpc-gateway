#!/bin/bash
#
# Script file to use curl command to test the grpc gateway.
#

URL="http://localhost:8090"
ENDPOINT="v1/helloworld"
NUM_ARGS=1
FILE_COOKIE=".cookie"
OPTS=""

# Function
SCRIPT_NAME=${0##*/}
Usage () {
	echo
	echo "Description:"
	echo "Script file to use curl command to test the grpc gateway."
	echo
	echo "Usage: $SCRIPT_NAME [name]"
	echo "Options:"
	echo " -k                           Allow https insecure connection"
	echo " -u  [url]                    IMS Customer Portal URL"
	echo " -h                           This help message"
	echo
}

# Parse input argument(s)
while [ "${1:0:1}" == "-" ]; do
	OPT=${1:1:1}
	case "$OPT" in
	"k")
		OPTS="$OPTS -k"
		;;
	"u")
		URL=$2
		shift
		;;
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

# trim URL trailing "/"
URL="$(echo -e "${URL}" | sed -e 's/\/*$//')"
NAME=$1

# list all users' info
curl $OPTS -vd "{\"name\": \"${NAME}\"}" -H 'Accept: application/json' ${URL}/${ENDPOINT}
