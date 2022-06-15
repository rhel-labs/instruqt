---
slug: step1
id: 5tlom6jx9cfp
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to deploy and control an already defined container image.

    #Concepts included in this scenario:
    * List available container images
    * Deploy a container image into an interactive container runtime
    * Deploy a container image into a detached container runtime
    * View deployed containers
    * Stop a container instances
    * Remove deployed container instances

    # Example Usecase:
    You have been asked to deploy a container running a web based application onto a server in your environment.  In addition to deploying it, you need to be able to start alternate copies and remove any non-running containers.
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
timelimit: 1600
---
>**Note:** In the `Terminal` tab in the upper left corner of the Instruqt web page, there are 2 shell sessions launched. To switch between the 2 shell sessions, press Ctrl-B and an arrow key pointing to the session you wish to become active.

First, go to pane 0.

![pane0](../assets/pane0.png)

Using the top terminal session, view the container images available.

```bash
podman images
```

<pre class=file>
REPOSITORY              TAG      IMAGE ID       CREATED        SIZE
localhost/rhel9-httpd   latest   c12e3720df7b   43 hours ago   499 MB

</pre>

There is one container available in the local (localhost) repository,
__rhel9-httpd__.  If there were multiple updated iterations of the conatiner
available, you would use the __IMAGE ID__ to work with those that are not
tagged as __latest__.  Also, from this list you are able to see the size, on
disk, of the container image.
