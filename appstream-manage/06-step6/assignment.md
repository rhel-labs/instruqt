---
slug: step6
id: wfmewucfvamx
type: challenge
title: Step 6
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Lastly, inspect all software managed as application streams.

```bash
yum module list
```

<pre class="file">
Red Hat Enterprise Linux 8 for x86_64-AppStream (RPMs)
Name                 Stream       Profiles                          Summary
389-ds               1.4                                            389 Directory Server (base)
ant                  1.10 [d]     common [d]                        Java build tool
container-tools      rhel8 [d][e] common [d]                        Common tools and dependencies for container runtimes
container-tools      1.0          common [d]                        Common tools and dependencies for container runtimes
container-tools      2.0          common [d]                        Common tools and dependencies for container runtimes
freeradius           3.0 [d]      server [d]                        High-performance and highly configurable free RADIUS server
gimp                 2.8 [d]      common [d], devel                 gimp module
go-toolset           rhel8 [d]    common [d]                        Go
httpd                2.4 [d][e]   common [d], devel, minimal        Apache HTTP Server

<<< OUTPUT ABRIDGED >>>
</pre>
