# Ubuntu

## Build

### Base Image

```
docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile \
    --build-arg BAMBOO_VERSION=6.8.0 \
    --tag ksb-bamboo-agent:nix-6.8.0 .
```

### Prewarmed Image

> Building this image requires a running Bamboo server at *BAMBOO_SERVER*, accessible from within
> the build containers. Agent authentication and security token verification needs to be disabled.

```
docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Prewarm \
    --build-arg BASE_IMAGE=ksb-bamboo-agent:6.8.0 \
    --build-arg BAMBOO_SERVER=http://host.docker.internal:6990/bamboo \
    --tag ksb-bamboo-agent:nix-6.8.0-prewarm .
```

### DinD Image

```
docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Dind \
    --build-arg BASE_IMAGE=ksb-bamboo-agent:6.8.0 \
    --tag ksb-bamboo-agent:nix-6.8.0-dind .
```

### Prewarmed DinD Image

```
docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Dind.Prewarm \
    --build-arg BASE_IMAGE=ksb-bamboo-agent:6.8.0-dind \
    --build-arg BAMBOO_SERVER=http://host.docker.internal:6990/bamboo \
    --tag ksb-bamboo-agent:nix-6.8.0-prewarm-dind .
```