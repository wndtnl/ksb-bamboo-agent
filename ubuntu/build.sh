#!/bin/bash

if [ -z ${1+x} ]; then
    echo "Please run this script with the Bamboo version as first argument (e.g. 6.8.0)"
    exit 1
fi

OS_FLAVOUR="nix"
BAMBOO_VERSION="${1}"

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
    --build-arg BAMBOO_SERVER=http://host.docker.internal:6990/bamboo \
    --tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm" .

docker tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm" "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm"
docker push "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm"

# Dind image

docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Dind \
    --build-arg BASE_IMAGE="ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}" \
    --tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-dind" .

docker tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-dind" "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-dind"
docker push "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-dind"

# Prewarmed dind image

docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Dind.Prewarm \
    --build-arg BASE_IMAGE="ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-dind" \
    --build-arg BAMBOO_SERVER=http://host.docker.internal:6990/bamboo \
    --tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm-dind" .

docker tag "ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm-dind" "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm-dind"
docker push "wndtnl/ksb-bamboo-agent:${OS_FLAVOUR}-${BAMBOO_VERSION}-prewarm-dind"
