---
slug: create-an-image
id: yhpyuxt9beme
type: challenge
title: Create a bootc image
teaser: Create a bootc image and push it to a local container registry.
notes:
- type: text
  contents: |
    # Goal:

    In this lab you will build, deploy, and manage a virtual machine that is running in image mode. You will create a new bootc image, push it to a registry, and convert it to a disk image for KVM.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Containerfile
  type: code
  hostname: rhel
  path: Containerfile
difficulty: basic
timelimit: 3000
---

Welcome to this lab experience for Red Hat Enterprise Linux.

The system displayed beside this text is a Red Hat Enterprise Linux 9
system registered with Subscription Manager.

Image mode uses standard container tools to define, build, and transport bootc images. Podman has already been installed on this host as a build environment, along with some additional files.

Examine the containerfile
===
Switch to the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab.

Click on `Containerfile`.

![](../assets/containerfile_scripteditor.png)

Image mode uses standard Containerfiles for defining the OS contents.

1. The `FROM` line defines the base image, in this case our new `bootc` base images, not a typical UBI application base image.
2. The `ADD` line allows us to add the complete contents of a directory at once, just like an application container.
3. The `RUN` directives add software and start services, just like an application container.

![](../assets/containerfile_elements.png)

Once you are done examining the Containerfile, click on the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab.

Build and push the container to the registry
===

Image mode uses standard container tools to build bootc images, like any other application container. Let's build this image with `podman build`.

```bash,run
podman build -t [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc .
```

Once built, bootc images use standard container registries for distribution. We are using a simple registry in this lab, but enterprise registries will provide ways to inspect contents, history, manage tags and more.

```bash,run
podman push [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc
```

Launch bootc-image-builder
===

To this point, we've been dealing with standard OCI images and tools. However, bootc images are intended to be systems, not run like application containers.

To boot this image as a host, we install it to the filesystem using `bootc`. But `bootc` doesn't know anything about creating disks or machines.

For the purposes of this lab, we'll create a QCOW2 image to be run on a KVM virtual machine. To build the QCOW2 image we'll use a tool called `bootc-image-builder`. This tool is a containerized version of image builder that includes the `bootc` tooling to unpack the container image contents to the virtual disk. Supported output formats include AMIs and VMDKs. For bare metal, we can use Anaconda with `bootc` support to install to physical disk.

```bash,run
podman run --rm --privileged \
        --volume .:/output \
         --volume ./config.json:/config.json \
        registry.redhat.io/rhel9/bootc-image-builder:latest \
        --type qcow2 \
        --config config.json \
         [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc
```

> [!NOTE]
> This operation will take 5 minutes to complete.

When the previous operation has completed, we'll deploy this disk image using KVM in the next step
