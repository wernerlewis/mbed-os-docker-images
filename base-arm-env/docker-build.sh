#!/usr/bin/env sh

set -e

docker build "$@" -t mbed/base-arm-env .
