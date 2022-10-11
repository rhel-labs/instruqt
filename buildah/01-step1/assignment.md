---
slug: step1
id: 139xozbexiac
type: challenge
title: Creating an application image from an existing base
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to build images from scratch or existing base images using **buildah** and other host based tools.

    # Concepts included in this scenario:
    * Initializing a working container for image building
    * Using buildah commands to modify a working container
    * Modfiying a working container with standard system tools
    * Creating an application image from a working container

    # Example Usecase:
    Using *podman* with a Containerfile or Dockerfile input is a common way to build containers from base images. However, this lab, Building containers with **buildah**, provides better control over layer creation and image contents.

    > _NOTE:_ Throughout these steps there are UUIDs in output blocks that may not match your output exactly.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 3420
---
**Buildah** has two main ways to create images:
* Using subcommands to modify contents
* Using host tools to modify a container filesystem

First, we'll look at using subcommands to modify the container contents before saving an image.  Many **buildah** subcommands act like directives from a Containerfile.  This allows for a familiar experience while automating builds.

The Red Hat Enterprise Linux 8 Universal Base Image is provided as the starting point for creating containers with Red Hat Enterprise Linux packages.  More information on UBI can be found in the [introductory blog post.](https://www.redhat.com/en/blog/introducing-red-hat-universal-base-image)

To build an application container from the `ubi-init` base image, we will create a working container with `buildah`.  A working container is a temporary container used as the target for buildah commands.

```bash
buildah from registry.access.redhat.com/ubi9/ubi-init
```

<pre class="file">
ubi-init-working-container
</pre>

This subcommand acts like the FROM directive in a Containerfile and makes the source image available on the host.

Buildah will append `-working-container` to the image name used.  If that name already exists, a number will also be appended.
