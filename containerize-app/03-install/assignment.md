---
slug: install
id: s0nj42hpefg0
type: challenge
title: Installing the target software
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
Now that the yum repositories are defined within the container, you can use
another `dnf install`, executed within the container, to install the target
software: `moon-buggy`.

```bash
buildah run ubi-working-container -- dnf -y install moon-buggy
```

<pre class="file">
<<< OUTPUT ABRIDGED>>>

==============================================================================================
 Package        Architecture       Version                 Repository          Size
==============================================================================================
Installing:
 moon-buggy     x86_64             1.0.51-30.el9           epel                79 k

<<< OUTPUT ABRIDGED >>>

Installed:  alsa-lib-1.2.8-3.el9.x86_64     audiofile-1:0.3.6-30.el9.x86_64   esound-libs-1:0.2.41-27.el9.x86_64    flac-libs-1.3.3-10.el9.x86_64   libogg-2:1.3.4-6.el9.x86_64       moon-buggy-1.0.51-30.el9.x86_64     

Complete!
</pre>

From the above output, you can see that `moon-buggy` was successfully installed
into the container.  The `dnf` transaction also installed several required
pieces of software as well.
