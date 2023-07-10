---
slug: build
id: tr8ezvrsckmv
type: challenge
title: Building a container with a different OS version and an unpackaged application
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: Containerized Web App
  type: service
  hostname: rhel
  path: /
  port: 8080
difficulty: basic
timelimit: 1
---
Pull a RHEL 9 UBI image that you will build your application into.

```bash
buildah from registry.access.redhat.com/ubi9/ubi
```

<pre class="file">
ubi9-working-container
</pre>

From the output above, you can see the image was successfully downloaded and a working container image was created and attached to the system with the name ubi9-working-container  You will use this working container in the next steps to install additional software packages into the image.
