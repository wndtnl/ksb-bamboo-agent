## Build

```
docker build \
    --progress=plain \
    --no-cache \
    --build-arg BAMBOO_VERSION=6.8.0 \
    -t ksb-bamboo-agent:6.8.0 .
```