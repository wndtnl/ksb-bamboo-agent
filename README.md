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

> Prewarmed agent images are images for which the classpath is synchronized with the Bamboo server as part of the image
> build. As such, the initial boot time of the agent is (significantly) reduced.

> Dind agent images are images in which the Docker client is installed, allowing communication with the docker
> daemon running in a separate container.

We provide prebuilt images on [DockerHub](https://hub.docker.com/r/wndtnl/ksb-bamboo-agent), which can be used to get started
quickly. We however advice more long-term users of the KSB plugin to fork or copy this repository and adjust,
build and publish derived images internally as needed. 

## Image Tags

The images published on DockerHub use the following tag pattern:

```
(nix|win)-<bamboo-version>[-prewarm][-dind]
```

Where the first section (*nix* or *win*) denotes the image base OS flavour: respectively (ubuntu) linux and windows (server).
Both are handled separately in the sub-folders of this repository.

Tag examples:

- nix-8.0.0: base image derived from ubuntu with the 8.0.0 version of the Bamboo agent JAR installed.
- nix-8.0.0-prewarm: image derived from the base image which was prewarmed against the 8.0.0 version of the Bamboo server.
- nix-8.0.0-dind: image derived from the base image with the Docker client installed.
- nix-8.0.0-prewarm-dind: image derived from the dind image, prewarmed against the 8.0.0 version of the Bamboo server.
