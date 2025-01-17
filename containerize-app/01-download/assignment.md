---
slug: download
id: 7yxqmka1ckum
type: challenge
title: Downloading the Universal Base Image
notes:
- type: text
  contents: |+
    # Goal:
    After completing this scenario, users will be able to install additional
    software into a container image.

    # Concepts included in this scenario:
    * Downloading a Red Hat Universal Base Image (UBI)
    * Positioning or configuring a container to use 3rd party repositories
    * Install 3rd party software into the container image
    * Commit changes to create a new container image
    * Validate the containerized application

    # Example Usecase:
    You have a piece of software that you would like to deploy within a container
    image rather than installing it natively on the host system.  By using a
    container image, you can copy the entire environment for the software to
    several different hosts or run multiple copies of it on the same system.



tabs:
- id: cg1daagtjk0z
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
The Red Hat Universal Base Image (UBI) is produced by Red Hat and is an easy
place to start when containerizing applications.  If you want to read more
about the UBI program, or the three different flavors of UBI, check out the
[FAQ - Universal Base Images](https://developers.redhat.com/articles/ubi-faq)
for additional details.

In this lab, you will be installing additional software into the container
image, however that software runs as an interactive application.  So you will
need `dnf`, but do not need `systemd` for managing services within the
container environment.  For that reason, you will be using the __Standard__
UBI image (as opposed to the Minimal or Multi-service images).

By executing the command below, your system will download the Standard UBI
image from Red Hat's registry.

```bash,run
buildah from registry.access.redhat.com/ubi9/ubi
```

<pre class="file">
Trying to pull registry.access.redhat.com/ubi9/ubi:latest...
Getting image source signatures
Checking if image destination supports signatures
Copying blob 7b3dd25bf011 done
Copying config 663a35613b done
Writing manifest to image destination
Storing signatures
ubi-working-container
</pre>

From the output above, you can see that the image was successfully downloaded
and a working container image was created and attached to the system with the
name of __ubi-working-container__.  You will use this working container in the
next steps to install additional software packages into the image.
