#!/bin/bash

set -e

SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")
SCRIPT_DIR=$(dirname ${SCRIPT_PATH})
MNT=$(dirname ${SCRIPT_DIR})
mkdir -p ${MNT}/bin/x86_64

if [[ $1 != "build" ]]; then
    docker run -it --rm -v ${MNT}:/hostfs --entrypoint=/hostfs/script/build-lightspeed-ingest-win.sh rust:latest build
    exit
fi

set -x

[[ ! -e /hostfs/Lightspeed-ingest ]] && echo "ERROR: Missing directory 'Lightspeed-ingest'" && exit 1

mkdir -p /cargo/src/
cp -R /hostfs/Lightspeed-ingest/* /cargo/src/
cd /cargo/src/

# Install OS dependencies
apt-get update
apt-get install -y gcc-mingw-w64

# Install rust cross compiler
rustup target add x86_64-pc-windows-gnu
rustup toolchain install stable-x86_64-pc-windows-gnu

# Build the release exe
cargo build --release --target x86_64-pc-windows-gnu

# Copy exe out of container
cp target/x86_64-pc-windows-gnu/release/lightspeed-ingest.exe /hostfs/bin/x86_64/
