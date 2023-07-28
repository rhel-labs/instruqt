---
slug: step1
id: gvpu61svegje
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this lab, users will be able to apply a Kernel Live Patch to
    a system, resolving a security vulnerability without rebooting into an updated
    kernel.

    # Concepts included in this lab:

    * Install Kernel Live Patching software and service
    * Deploy a Kernel Live Patch on a running system
    * Verify status of a Kernel Live Patch
    * Methodology to locate details and information for Common Vulnerabilities and Exposures (CVEs) published by Red Hat

    # Example Usecase:

    To provide an alternative to emergency kernel maintenance events for
    the mitigation of Critical kernel CVEs.  It is expected that after an
    organization has live patched a running kernel that they will, at some point,
    schedule a maintenance window to apply the updated kernel package to the
    system and perform a system reboot.  Kernel Live Patching allows the
    organization to determine when this window occurs rather than the release of
    a fix for a Critical CVE.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3000
---
## Getting started with Kernel Live Patching

When a Critical severity Common Vulnerability and Exposure (CVE) is
announced, Red Hat produces updated software package that include fixes for
the CVE.  However, historically, to apply an updated kernel package,
organizations needed to schedule a system maintenance as the procedure for
applying a new kernel included a system reboot.

Kernel Live Patching is a service intended for use with Red Hat Enterprise Linux
Extended Update Support (EUS) versions.  Red Hat packages Kernel Live Patches
(kpatches) for selected CVEs, which organizations can apply to their running
Red Hat Enterprise Linux systems to update the system without scheduling a
system downtime to apply a kernel update to address the CVE.

To get started, install the `kpatch` package:

```bash
dnf -y install kpatch
```

Now that the `kpatch` application is installed, you can verify that the
system does not currently have any kpatches loaded into the kernel.

```bash
kpatch list
```

<pre class=file>
Loaded patch modules:

Installed patch modules:

</pre>

As expected, no patch modules are loaded or installed on the machine ... yet.
