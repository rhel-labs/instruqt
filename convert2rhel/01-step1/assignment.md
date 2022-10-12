---
slug: step1
id: ujri9ug22z4k
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to convert a CentOS Linux instance to a Red Hat Enterprise Linux instance.

    # Concepts included in this scenario:
    * Subscribing to additional repositories
    * Convert2RHEL utility

    # Example Usecase:
    In order to standardize your infrasturcture under a single platform, you need to convert your RPM-based servers over to Red Hat Enterprise Linux.
tabs:
- title: Terminal
  type: terminal
  hostname: host
difficulty: basic
timelimit: 600
---

# What is Convert2RHEL

Convert2RHEL is a command line utility that allows for self-service migration between RHEL-like distributions to officially supported Red Hat Enterprise Linux instances.

The convert2rhel tool handles subscribing the target system to your Red Hat customer account while maintaining customizations, configurations, and workloads.

Convert2RHEL is also a supported operation which means if you run into issues with the conversion process, you can open a ticket with Red Hat Support.

# Enabling the Convert2RHEL repository

The Convert2RHEL RPM is an offical Red Hat package. Therefore it is readily availble from the Red Hat software repository (CDN). As your CentOS server is not subscribed to the Red Hat CDN, you will need to enable the Convert2RHEL repository.

First, you will pull down the GPG signing key:

```
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt
```

<pre class='file'>
# curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1855  100  1855    0     0   2324      0 --:--:-- --:--:-- --:--:--  2324
</pre>

Second, download the SSL certificate:

```
curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem
```

<pre class='file'>
# curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7411  100  7411    0     0  15260      0 --:--:-- --:--:-- --:--:-- 15280
</pre>

Thirdly, download the convert2rhel repository file:

```
curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/7/convert2rhel.repo
```

<pre class='file'>
# curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/7/convert2rhel.repo
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   247  100   247    0     0    509      0 --:--:-- --:--:-- --:--:--   510
</pre>
