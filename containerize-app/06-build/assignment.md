---
slug: build
id: tr8ezvrsckmv
type: challenge
title: Building a container with a different OS version and an unpackaged application
tabs:
- id: ijf1xxmqalhp
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Pull a RHEL 8 UBI image that you will build your application into.

```bash,run
buildah from registry.access.redhat.com/ubi8/ubi
```

<pre class="file">
Trying to pull registry.access.redhat.com/ubi8/ubi:latest...
Getting image source signatures
Checking if image destination supports signatures
Copying blob 6c53be4efe39 done
Copying config e8e5725e8a done
Writing manifest to image destination
Storing signatures
ubi-working-container-1
</pre>

From the output above, you can see the image was successfully downloaded and a working container image was created and attached to the system with the name `ubi-working-container-1`  You will use this working container in the next steps to install additional software packages into the image.
