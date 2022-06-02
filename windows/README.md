# Windows

## Build

### Base Image

```
docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile \
    --build-arg BAMBOO_VERSION=8.0.0 \
    --tag ksb-bamboo-agent:win-8.0.0 .
```

### Prewarmed Image

> Building this image requires a running Bamboo server at *BAMBOO_SERVER*, accessible from within
> the build containers. Agent authentication and security token verification needs to be disabled.

```
docker build \
    --progress=plain \
    --no-cache \
    --file Dockerfile.Prewarm \
    --build-arg BASE_IMAGE=ksb-bamboo-agent:win-8.0.0 \
    --build-arg BAMBOO_SERVER=http://host.docker.internal:6990/bamboo \
    --tag ksb-bamboo-agent:win-8.0.0-prewarm .
```

## Run

```
docker run -it --rm --name bamboo-agent \
    -v bamboo-agent-home:"c:\\Users\\bamboo\\bamboo-agent-home" \
    ksb-bamboo-agent:win-8.0.4-prewarm http://host.docker.internal:6990/bamboo
```