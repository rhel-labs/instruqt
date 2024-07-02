---
slug: create-an-image
id: yhpyuxt9beme
type: challenge
title: Create a bootc image
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

```bash,run
podman images
```

<div style="border: 1px solid black; border-radius: 5px; padding-left: 1em; padding-bottom: 1em; background-color: lightgray; color: black; border-radius: 5px;">
  <h3 style="color: black; border-radius: 5px;">✅ Use Tab: <strong>Containerfile</strong></h3>
</div>

If not already shown, select Containerfile in the list on the right side of the tab.

Image mode relies on standard Containerfiles for defining the OS. The `FROM` line defines the base image, the RUN directives add software and start services, and the ADD line allows us to add the complete contents of a directory at once.

Once you are done examining the Containerfile, return to the Terminal.

<div style="border: 1px solid black; border-radius: 5px; padding-left: 1em; padding-bottom: 1em; background-color: lightgray; color: black; border-radius: 5px;">
  <h3 style="color: black; border-radius: 5px;">✅ Use Tab: <strong>Terminal</strong></h3>
</div>

Build the container like you would any other application container with `podman build`. The `REGISTRY` variable is a convenience to save typing during the lab and is the FQDN of this host and the standard container registry port 5000.

```bash,run
podman build -t ${REGISTRY}/test-bootc .
```
Once the container has been built, we can push it to our registry for distribution. We are using a simple registry in this lab, but enterprise registries will provide ways to inspect contents, history, manage tags and more.

```bash,run
podman push ${REGISTRY}/test-bootc
```

With the image available in the registry, we can use standard container tools to get information about it. Let's use `skopeo` to get the SHA256 image digest of this image. We will use that later in the lab, so we'll store the output in a file.
```bash,run
skopeo inspect docker://${REGISTRY}/test-bootc | jq '.Digest' | tee sha256.orig
```

To this point, we've been dealing with standard OCI images and tools. But container images themselves aren't designed to be run outside of a container engine. To run this image as a host, we install it to disk using `bootc`.

For bare metal, we can use Anaconda with `bootc` support to install to disk, but to create a QCOW2 image for a KVM virtual machine we'll use `bootc-image-builder`. This is a containerized version of image builder that includes the bootc tooling to install the container image contents to disk. This can also create other types of disk images like AMIs or VMDKs.

```bash,run
podman run --rm --privileged \
        --volume .:/output \
         --volume ./config.json:/config.json \
        registry.redhat.io/rhel9/bootc-image-builder:latest \
        --type qcow2 \
        --config config.json \
         ${REGISTRY}/test-bootc
```

Let's deploy this disk image using KVM in the next step