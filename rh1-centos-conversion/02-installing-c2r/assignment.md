---
slug: installing-c2r
id: a5kojk7ritjf
type: challenge
title: Installing Convert2RHEL
tabs:
- title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
difficulty: basic
---

## Installing the Convert2RHEL utility

In the previous step, you enabled the Convert2RHEL software repository. That gave your CentOS Linux server access to the convert2rhel RPM package and its dependencies from the Red Hat CDN. Verify that the Convert2RHEL repo is enabled:

```bash
yum repolist

```

<pre class='file'>
# yum repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: ftp.pasteur.fr
 * extras: centos.mirror.ate.info
 * updates: ftp.pasteur.fr
repo id                                                                                   repo name                                                                          status
base/7/x86_64                                                                             CentOS-7 - Base                                                                    10,072
convert2rhel-for-rhel-7-rpms                                                              Convert2RHEL for OS 7                                                                   5
extras/7/x86_64                                                                           CentOS-7 - Extras                                                                     512
updates/7/x86_64                                                                          CentOS-7 - Updates                                                                  4,053
repolist: 14,642
</pre>

Now that the repository has been confirmed enabled, install the convert2rhel utility:

```bash
yum install -y convert2rhel

```

<pre class='file'>
# yum install -y convert2rhel
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: ftp.pasteur.fr
 * extras: centos.mirror.ate.info
 * updates: ftp.pasteur.fr
Resolving Dependencies
--> Running transaction check

... output truncated ...

Installed:
  convert2rhel.noarch 0:0.26-1.el7

Dependency Installed:
  libxml2-python.x86_64 0:2.9.1-6.el7_9.6  pexpect.noarch 0:2.3-11.el7             python-backports.x86_64 0:1.0-8.el7  python-backports-ssl_match_hostname.noarch 0:3.5.0.1-1.el7
  python-chardet.noarch 0:2.2.1-3.el7      python-ipaddress.noarch 0:1.0.16-2.el7  python-kitchen.noarch 0:1.1.1-5.el7  python-setuptools.noarch 0:0.9.8-7.el7
  python-six.noarch 0:1.9.0-2.el7          yum-utils.noarch 0:1.1.31-54.el7_8

Complete!
</pre>

In the next step, you will begin the conversion process.
