---
slug: install-podman
id: sdacxyrag13f
type: challenge
title: Install Podman
teaser: Install Podman.
notes:
- type: text
  contents: |-
    Podman is a cloud-native, daemonless tool that helps developers manage their Linux containers. Podman stands out from other container engines because it’s daemonless, meaning it doesn't rely on a process with root privileges to run containers.

    Users can invoke Podman from the command line to pull containers from a repository and run them. Podman calls the configured container runtime to create the running container. But without a dedicated daemon, Podman uses systemd—a system and service manager for Linux operating systems—to make updates and keep containers running in the background. By integrating systemd and Podman, you can generate control units for your containers and run them with systemd automatically enabled.

    Read more about the [differences between Podman and Docker here](https://developers.redhat.com/articles/2023/08/03/3-advantages-docker-podman#).

    Read more about [Podman here](https://www.redhat.com/en/topics/containers/what-is-podman#overview).
tabs:
- id: pgfhksxingzs
  title: rhel
  type: terminal
  hostname: rhel
  cmd: exec bash
difficulty: ""
timelimit: 0
enhanced_loading: null
---
Install Podman
===
The first task is to install Podman.

Click on the `run` button for the code block below.

```bash,run
dnf install -y podman
```
The output should look similar to the following screenshot.

![Aug-27-2024_at_12.36.58-image.png](../assets/Aug-27-2024_at_12.36.58-image.png)

Proceed to the next assignment.
