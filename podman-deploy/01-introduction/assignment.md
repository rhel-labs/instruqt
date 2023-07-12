---
slug: introduction
id: 5tlom6jx9cfp
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to deploy and control an already defined container image.

    # Concepts included in this scenario:
    * List available container images
    * Deploy a container image into an interactive container runtime
    * Deploy a container image into a detached container runtime
    * View deployed containers
    * Stop a container instances
    * Remove deployed container instances

    # Example Usecase:
    You have been asked to deploy a container running a web based application onto a server in your environment.  In addition to deploying it, you need to be able to start alternate copies and remove any non-running containers.
tabs:
- title: Podman
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "podman" > /dev/null 2>&1
- title: RHEL Host
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "host" > /dev/null 2>&1
difficulty: basic
timelimit: 3000
---
In this lab we have two terminals to make navigation easier. The `Podman` terminal will be used for podman related tasks. The `RHEL Host` tab will be used for host related tasks.

![nav tabs](../assets/navtabs.png)

Click on the `Podman` tab.

Enter the following command to view the existing images on the RHEL host.

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
