---
slug: introduction
id: hmlyy4hna4nv
type: challenge
title: Introduction
tabs:
- title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
difficulty: basic
timelimit: 3300
---

## What is Convert2RHEL

Convert2RHEL is a command line utility that allows for self-service migration between RHEL-like distributions to officially supported Red Hat Enterprise Linux instances.

The convert2rhel tool handles subscribing the target system to your Red Hat customer account while maintaining customizations, configurations, and workloads.

Convert2RHEL is also a supported operation which means if you run into issues with the conversion process, you can open a ticket with Red Hat Support.

Before you begin the installation process, verify that you are running CentOS Linux and on the latest minor version.

```bash,run
cat /etc/centos-release

```

<pre class='file'>
# cat /etc/centos-release
CentOS Linux release 7.9.2009 (Core)
</pre>

## Enabling the Convert2RHEL repository

The Convert2RHEL RPM is an offical Red Hat package. Therefore it is readily availble from the Red Hat software repository (CDN). As your CentOS server is not subscribed to the Red Hat CDN, you will need to enable the Convert2RHEL repository.

First, you will pull down the GPG signing key:

```bash,run
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt

```

<pre class='file'>
# curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1855  100  1855    0     0   2324      0 --:--:-- --:--:-- --:--:--  2324
</pre>

Second, download the SSL certificate:

```bash,run
curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem

```

<pre class='file'>
# curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7411  100  7411    0     0  15260      0 --:--:-- --:--:-- --:--:-- 15280
</pre>

Thirdly, download the convert2rhel repository file:

```bash,run
curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/7/convert2rhel.repo

```

<pre class='file'>
# curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/7/convert2rhel.repo
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   247  100   247    0     0    509      0 --:--:-- --:--:-- --:--:--   510
</pre>
