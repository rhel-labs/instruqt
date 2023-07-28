---
slug: step3
id: o3ebey9xpnps
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 1
---
## Applying a Kernel Live Patch

You could now install the specific kpatch-patch package you discovered from the
previous step.  However, if you were wanting to do this action on a population
of systems, which may each be running a different kernel (because of where they
are in your normal population maintenance, perhaps).  Instead, Red Hat
recommends using a dnf install or update command that embeds a uname -r
command to dynamically determine the running kernel version and utilize it
when making the decision of which kpatch to install:

```bash
dnf -y install "kpatch-patch = $(uname -r)"
```

<pre class="file">
<< OUTPUT ABRIDGED >>

===========================================================================================================================================
 Package                                    Architecture         Version                 Repository                                   Size
===========================================================================================================================================
Installing:
 kpatch-patch-5_14_0-284_11_1               x86_64               1-1.el9_2               rhel-9-for-x86_64-baseos-rpms                19 k

Transaction Summary
===========================================================================================================================================
Install  1 Package

<< OUTPUT ABRIDGED >>
</pre>

The previous `dnf` command, based on the result of the embedded uname -r
command, installed kpatch-patch-5_14_0-284_11_1, which is what you had
determined on the previous step to be the patchset for this system.
