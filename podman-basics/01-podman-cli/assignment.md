---
slug: podman-cli
id: d5rumxknrnth
type: challenge
title: Introduction to the podman command-line
tabs:
- id: 9gxrxvlpevgk
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Podman CLI

The first thing we'll work with is the podman CLI.  If you are familiar with containers on docker, you'll find a lot of the work here to be almost identical to the command-line you're used to on docker.  This is on purpose.  Podman has a docker compatible command set, it also runs the same Open Container Initiative (OCI) compliant images that you may be used to running on docker.

Throughout this lab we'll be using container images, in fact, that came right from docker hub, but we'll also see container images from other sources.

## Verifying that podman is installed

First, let's see what version of podman we're working with.

```bash,run
podman --version
```

This should return something like this:

<pre class="file">
podman version 5.2.2
</pre>

Let's also look to see what images are available to us locally

```bash,run
podman image list
```

<pre class="file">
REPOSITORY                           TAG         IMAGE ID      CREATED      SIZE
docker.io/library/httpd              latest      f7d8bafbd9a9  10 days ago  152 MB
registry.access.redhat.com/ubi9/ubi  latest      4d9d35858951  3 weeks ago  234 MB
</pre>

## Look for running containers

Now let's see if there are any containers running

```bash,run
podman ps
```

You should see a container running named default-httpd

<pre class="file">
CONTAINER ID  IMAGE                           COMMAND           CREATED        STATUS        PORTS       NAMES
65028bd1bc1b  docker.io/library/httpd:latest  httpd-foreground  4 seconds ago  Up 4 seconds  80/tcp      default-httpd
</pre>

## Stopping, starting, and removing containers

To stop a container, you use the ```podman stop [identifier]``` command.  The `identifier` can be either the container's name, or ID.  Let's stop default-httpd by its name.

```bash,run
podman stop default-httpd
```

Podman confirms this action only by returning the container's ID or Name (depending on the podman version) that you stopped.  Now, ```podman ps``` will show no running containers, but the container isn't gone, you can see all containers, using the ```podman ps -a``` command. Let's try that.

```bash,run
podman ps -a
```

You should see a list of all containers, including those that are stopped, along with their state.

<pre type="file">
CONTAINER ID  IMAGE                           COMMAND           CREATED        STATUS                         PORTS       NAMES
65028bd1bc1b  docker.io/library/httpd:latest  httpd-foreground  9 minutes ago  Exited (0) About a minute ago  80/tcp      default-httpd
</pre>

We can start the container again with ```podman start [identifier]```, again the identifier can be the container ID, or it's name.

```bash,run
podman start default-httpd
```

Just like when we stopped it, podman should only return the containers Name, or ID, if it succeeded.

Now, what about deleting containers?  You can use ```podman rm [identifier]``` to remove a container.

First let's stop that running container, then we'll remove it.
```bash,run
podman stop default-httpd && podman rm default-httpd
```

You should get the identifier back twice, because we performed two actions on the same container.  Now a ```podman ps -a``` should return no containers.

```bash,run
podman ps -a
```

<pre type="file">
root@rhel:~# podman ps -a
CONTAINER ID  IMAGE       COMMAND     CREATED     STATUS      PORTS       NAMES
root@rhel:~#
</pre>

## Working with Images

What if we need a new image from our container registry?  A container registry is sort of like a package repository, or even a code repository.  It's a central place where our container images live.  Those images will usually have different builds, or versions associated with them, separated by Tags.  By default podman will pull the `latest` tag.  Let's try to pull a specific build of the mariadb image, from the Docker Hub public registry.

```bash,run
podman pull docker.io/mariadb:lts-ubi9

```

You'll see an output similar to this:

<pre type="file">
root@rhel:~# podman pull docker.io/mariadb:lts-ubi9
Trying to pull docker.io/library/mariadb:lts-ubi9...
Getting image source signatures
Copying blob ecdcadf54a6d done   |
Copying blob eeaa3613f51c done   |
Copying blob 5808a11b7bed done   |
Copying blob e8010f9b2c46 done   |
Copying blob e1b03035629f done   |
Copying blob da657d20cffa done   |
Copying blob 7a7a7c7eff26 done   |
Copying blob aadc5517d0a5 done   |
Copying blob 738aba559af0 done   |
Copying blob 665a92a0dd93 done   |
Copying config d66617516c done   |
Writing manifest to image destination
d66617516cb22cd79cc8fff3a894f7bd9e91788ff9aa1b9e78d4518e3e92c452
</pre>

Much like parfait, images have layers.  These multiple lines of "copying blob..." are the various layers of this container image being downloaded and built into the container image. And everybody loves parfait.

Now, you'll find the `mariadb:lts-ubi9` image in your local list of container images.

A note on tags.  in this example, we downloaded the mariadb build based on the RHEL 9 Universal Base Image.  This is denoted by the tag `lts-ubi9`.  If you left off the tag, podman would have defaulted to downloading `mariadb:latest` which in this case is a container built on an entirely different base.  Containers give us this sort of flexibility.

```bash,run
podman image list
```

<pre type="file">
root@rhel:~# podman image list
REPOSITORY                           TAG         IMAGE ID      CREATED       SIZE
docker.io/library/httpd              latest      f7d8bafbd9a9  10 days ago   152 MB
registry.access.redhat.com/ubi9/ubi  latest      4d9d35858951  3 weeks ago   234 MB
docker.io/library/mariadb            lts-ubi9    d66617516cb2  3 months ago  470 MB
</pre>

Now, we don't actually need that mariadb container, but it would be useful for you to know how to delete a container image.  Let's delete `mariadb:lts-ubi9`

```bash,run
podman rmi docker.io/mariadb:lts-ubi9
```

And you'll get the following output:

<pre type="file">
root@rhel:~# podman rmi docker.io/mariadb:lts-ubi9
Untagged: docker.io/library/mariadb:lts-ubi9
Deleted: d66617516cb22cd79cc8fff3a894f7bd9e91788ff9aa1b9e78d4518e3e92c452
</pre>

What's that Untagged line all bout?  Podman maintains tags for every image locally, this is used for more advanced podman work than we'll approach in this lab.  But this is how you tell podman where to `push` an image if you were to make changes to it (assuming you have the permission to push a container to that registry).

Now, in the next step we'll learn how to run a new container in podman!