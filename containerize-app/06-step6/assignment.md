---
slug: step6
id: tr8ezvrsckmv
type: challenge
title: Building a container with a different OS version and an unpackaged application
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Containerized Web App
  type: service
  hostname: rhel
  path: /
  port: 8080
difficulty: basic
timelimit: 1
---
Pull a RHEL 8 UBI image that you will build your application into.
```bash
buildah from registry.access.redhat.com/ubi8/ubi
```

<pre class="file">
Trying to pull registry.access.redhat.com/ubi8/ubi:latest...
Getting image source signatures
Checking if image destination supports signatures
Copying blob 809fe483e885 done
Copying blob 1b3417e31a5e done
Copying config 10f854072e done
Writing manifest to image destination
Storing signatures
ubi-working-container-1
</pre>

From the output above, you can see the image was successfully downloaded and a working container image was created and attached to the system with the name __ubi-working-container-1__.  You will use this working container in the next steps to install additional software packages into the image.
