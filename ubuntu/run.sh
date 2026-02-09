#!/bin/bash

if [ -z ${1+x} ]; then
    echo "Please run this script with the Bamboo version as first argument (e.g. 6.8.0)"
    exit 1
fi

if [ -z ${2+x} ]; then
    echo "Please run this script with the Bamboo server URL as second argument"
    exit 1
fi

BAMBOO_VERSION="${1}"
BAMBOO_SERVER="${2}"

docker run -i -t "wndtnl/ksb-bamboo-agent:nix-${BAMBOO_VERSION}" "${BAMBOO_SERVER}"
