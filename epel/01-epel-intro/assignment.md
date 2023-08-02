---
slug: epel-intro
id: zrufakzrbxnx
type: challenge
title: Extra Packages for Enterprise Linux
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: ""
timelimit: 3000
---
In this lab, you will learn about [Extra Packages for Enterprise Linux (EPEL)](https://docs.fedoraproject.org/en-US/epel/), a series of Fedora-derived packages designed to increase the flexibility of working with Red Hat Enterprise Linux. Although EPEL's packages are derived from Fedora, it has been curated such that none of the packages in EPEL should conflict with anything that ships with RHEL, meaning that EPEL enables greater flexibility for users while maximizing compatibility with RHEL.

Suppose that you wish to use Conda for programming. In this lab, we will install Conda, but you can install any package from EPEL with the same steps, simply changing the name of the package you use in your `dnf install` command.

First, let's try to install Conda without enabling EPEL. To do this, run the following command:
```bash
dnf install -y conda
```
The installation will not be successful because your package manager (dnf) does not have access to a repository containing Conda. As such, you will see an output that resembles this:
<pre class="file">

</pre>

To enable EPEL, run the following command:
```bash
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```
