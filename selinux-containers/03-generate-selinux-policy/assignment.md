---
slug: generate-selinux-policy
id: p32zmlmedrlm
type: challenge
title: Generating SELinux container policies with Udica
tabs:
- title: Terminal 1
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "Terminal1" > /dev/null 2>&1
- title: Terminal 2
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "Terminal2" > /dev/null 2>&1
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 1
---
To create the custom SELinux security policy, Udica scans the container JSON
file to discover which Linux capabilities are required by the container. The
network ports are a similar situation where Udica uses the SELinux userspace
libraries to get the correct SELinux label of a port that is used by the
inspected container.

In the `Terminal 1` tab of the lab interface, inspect the running container using
podman to generate a container inspection file in JSON format

```bash
podman inspect $CONTAINERID > container.json
```

Tell Udica to generate the custom SELinux security policy by using the container
JSON file. In this case the name of the custom SELinux security policy is called
'my_container'

```bash
udica -j container.json my_container
```

<pre class="file">

Policy my_container created!

Please load these modules using:
\# semodule -i my_container.cil /usr/share/udica/templates/{base_container.cil,net_container.cil,home_container.cil}

Restart the container with: "--security-opt label=type:my_container.process" parameter
</pre>

You just created a custom SELinux security policy for the container. Now you can
load this policy into the kernel and make it active.

```bash
semodule -i my_container.cil /usr/share/udica/templates/{base_container.cil,net_container.cil,home_container.cil}
```

In `Terminal 1`, stop and re-launch the container so that the policies take effect.

```bash
podman stop $CONTAINERID
```

In `Terminal 2`, create a new container runtime from the image which uses the new, custom container policy

```bash
CONTAINER=$(podman run --security-opt label=type:my_container.process -v /home:/home:ro -v/var/spool:/var/spool:rw -d -p 80:80 -it registry.access.redhat.com/ubi9/ubi)
```
