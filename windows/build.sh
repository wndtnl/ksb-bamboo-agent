#!/bin/bash

if [ -z ${1+x} ]; then
    echo "Please run this script with the Bamboo version as first argument (e.g. 6.8.0)"
    exit 1
fi

if [ -z ${2+x} ]; then
    echo "Please run this script with the Bamboo server URL as second argument"
    exit 1
fi

OS_FLAVOUR="win"
BAMBOO_VERSION="${1}"
BAMBOO_SERVER="${2}"

# Base image

docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile \
    --build-arg BAMBOO_VERSION="${BAMBOO_VERSION}" \
    --tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}" .

docker tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}" "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}"
docker push "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}"

# Prewarmed image

docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Prewarm \
    --build-arg BASE_IMAGE="ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}" \
    --build-arg BAMBOO_SERVER="${BAMBOO_SERVER}/bamboo" \
    --tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm" .

docker tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm" "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm"
docker push "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm"
