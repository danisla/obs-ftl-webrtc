#!/bin/bash

set -e

SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")
SCRIPT_DIR=$(dirname ${SCRIPT_PATH})
MNT=$(dirname ${SCRIPT_DIR})
mkdir -p ${MNT}/bin/x86_64

if [[ $1 != "build" ]]; then
    docker run -it --rm -v ${MNT}:/hostfs --entrypoint=/hostfs/script/build-lightspeed-webrtc-win.sh golang:1.14 build
    exit
fi

set -x

[[ ! -e /hostfs/Lightspeed-webrtc ]] && echo "ERROR: Missing directory 'Lightspeed-webrtc'" && exit 1

mkdir -p /go/src/app
cp -R /hostfs/Lightspeed-webrtc/* /go/src/app/
cd /go/src/app

export GO111MODULE=on
export GOOS=windows
export GOARCH=amd64

go mod download
go build -o lightspeed-webrtc.exe .

cp /go/src/app/lightspeed-webrtc.exe /hostfs/bin/x86_64/