# KSB Bamboo Agent

This repository holds the Docker and supporting files needed to build Bamboo agent
images compatible with the [Kubernetes (Agents) for Bamboo](https://windtunnel.io/products/ksb) (KSB) plugin.

Atlassian is maintaining a similar [repository](https://bitbucket.org/atlassian-docker/docker-bamboo-agent-base),
providing agent images on [DockerHub](https://hub.docker.com/r/atlassian/bamboo-agent-base).
However, the KSB plugin makes certain assumptions on the agent images to function correctly. As we have no control
over the direction taken or changes made by Atlassian to their images, we provide this repository
with images which are tested against, and guaranteed compatible with the plugin.

Also, Atlassian does not provide *prewarmed*, *dind* nor *windows (server)* compatible images, which we strive to
maintain in this repository as well.

We advice users of the KSB plugin to fork or copy this repository and adjust, build and publish derived
images internally as needed. 

## Image Tags

The images published on DockerHub use the following tag pattern:

```
<bamboo-version>[-prewarm][-dind]
```

Examples:

- 8.0.0: base image with the 8.0.0 version of the Bamboo agent JAR installed.
- 8.0.0-prewarm: base image which was prewarmed against the 8.0.0 version of the Bamboo server.
- 8.0.0-prewarm-dind: prewarmed image for Bamboo 8.0.0, with the Docker client installed.
- 8.0.0-dind: base image with the Docker client installed.

## Image Flavours

Two flavours of the agent images are available: ubuntu and windows, depending on the base
image used.

### Ubuntu

Please see the *ubuntu* subfolder of this repository.

### Windows

Please see the *windows* subfolder of this repository.