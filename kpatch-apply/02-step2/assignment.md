---
slug: step2
id: bucn78vox34o
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
## Determine what Kernel Live Patches are available

When Kernel Live Patches are applied to the kernel, functions within the
kernel are re-routed from their initial instructions to instead use the
functions provided by the kpatch.  The following diagram provides a bit
more detail on how this process operates.

![Web Console Login](../assets/rhel_kpatch_overview.png)
Image from the [Red Hat Kernel Adminstration Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/applying_patches_with_kernel_live_patching)

This means that a kpatch is produced and tied to a specific version of the
kernel.  Before you look at available kernel patches, you should first know
the version of the kernel running on your target system.

```bash
uname -r
```

<pre class=file>
5.14.0-284.11.1.el9_2.x86_64
</pre>

Our lab system is running kernel version (also known as release, hence the -r
option used by uname) 5.14.0-284.11.1.el9_2.x86_64.

Now that you know the version of the kernel running on the lab machine, look
at all of the aviailable kpatch packages avaiable from the Red Hat Enterprise
Linux repos.

```bash
dnf list available kpatch-patch*284*
```

<pre class='file'>
<< OUTPUT ABRIDGED >>

Available Packages
kpatch-patch-5_14_0-284_11_1.x86_64                                 1-1.el9_2                                 rhel-9-for-x86_64-baseos-rpms
kpatch-patch-5_14_0-284_18_1.x86_64                                 0-0.el9_2                                 rhel-9-for-x86_64-baseos-rpms
</pre>

From the above output, there are several different kpatch-patch patches
available, but only one of them is the one intended for the kernel running on
your system.  The one needed for your system is
`kpatch-patch-5_14_0-284_11_1.x86_64` because it is the latest available for
the version of your kernel reported by `uname -r`, specifically, 5.14.0-284.el9_2.

If you looked at all available `kpatch-patch` packages, you would see others
listed, like `kpatch-patch-5_14_0-162_18_1.x86_64`.  These kpatches are
for another kernel, specifically, version 5.14.0-162.  You can see that
the additional listings are also for addtional kernel releases, __not__ the one
running on your system.

In the next step, you will be applying the kpatch available for your system
to the kernel.
