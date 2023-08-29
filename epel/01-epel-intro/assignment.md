---
slug: epel-intro
id: zrufakzrbxnx
type: challenge
title: Extra Packages for Enterprise Linux
notes:
- type: text
  contents: |-
    In this lab, you will learn about [Extra Packages for Enterprise Linux (EPEL)](https://docs.fedoraproject.org/en-US/epel/), a repository of packages designed to increase the flexibility of working with Red Hat Enterprise Linux. EPEL has been curated such that none of the packages in EPEL should conflict with anything that ships with RHEL, meaning that EPEL enables greater flexibility for users while maximizing compatibility with RHEL.

    **Note:** If you choose to use the RHEL web console at any point during this lab, you can log in using the following credentials:
    - Username: rhel
    - Password: redhat
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
In this lab, you will learn about [Extra Packages for Enterprise Linux (EPEL)](https://docs.fedoraproject.org/en-US/epel/), a repository of packages designed to increase the flexibility of working with Red Hat Enterprise Linux. EPEL has been curated such that none of the packages in EPEL should conflict with anything that ships with RHEL, meaning that EPEL enables greater flexibility for users while maximizing compatibility with RHEL.

>**Note:** If you choose to use the RHEL web console at any point during this lab, you can log in using the following credentials:
>- Username: rhel
>- Password: redhat

Suppose that you wish to use Conda for programming. In this lab, we will install Conda, but you can install any package from EPEL with the same steps by changing the name of the package in your `dnf install` command.

First, let's try to install Conda without enabling EPEL. To do this, run the following command:
```bash
dnf install -y conda
```
The installation will not be successful because your package manager (dnf) does not have access to a repository containing Conda. As such, you will see an output that resembles this:
<pre class="file">
<< output abridged >>
Error: Unable to find a match: conda
</pre>

We can fix this problem by enabling EPEL with the following command:
```bash
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```
The output will look like this:
<pre class="file">
<< output abridged >>
Installed:
  epel-release-9-5.el9.noarch

Complete!
</pre>

You have now successfully enabled Extra Packages for Enterprise Linux. You can verify your installation by running the following command:
```bash
dnf repolist
```
After running this command, you will be presented with a list of enabled software repositories. One of the lines should contain `epel` or `Extra Packages for Enterprise Linux 9 - x86-64`.

Now that you have confirmed the EPEL installation, try installing Conda:
```bash
dnf install -y conda
```
This time, the last line of output should say `Complete!` indicating that you have successfully installed Conda.

To verify that Conda is installed and working properly, run this command to view the version of Conda that is installed on your system
```bash
conda -V
```
The output of this command should look like `conda 4.14.0`. The exact number may change as new versions of Conda are released, but it will remain in this format.