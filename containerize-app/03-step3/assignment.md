---
slug: step3
id: s0nj42hpefg0
type: challenge
title: Installing the target software
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
timelimit: 60
---
Now that the yum repositories are defined within the container, you can use
another `yum install`, executed within the container, to install the target
software: `moon-buggy`.

```bash
buildah run ubi-working-container -- yum -y install moon-buggy
```

<pre class="file">
<<< OUTPUT ABRIDGED>>>

==========================================================================================================================================
 Package                    Architecture          Version                           Repository                                       Size
==========================================================================================================================================
Installing:
 moon-buggy                 x86_64                1.0.51-25.el8                     epel                                             81 k

<<< OUTPUT ABRIDGED >>>

Installed:
  lsa-lib-1.2.4-5.el8.x86_64     audiofile-1:0.3.6-23.el8.x86_64
  esound-libs-1:0.2.41-22.el8.x86_64    flac-libs-1.3.2-9.el8.x86_64
  libogg-2:1.3.2-10.el8.x86_64    moon-buggy-1.0.51-25.el8.x86_64

Complete!
</pre>

From the above output, you can see that `moon-buggy` was successfully installed
into the container.  The `yum` transaction also installed several required
pieces of software as well.
