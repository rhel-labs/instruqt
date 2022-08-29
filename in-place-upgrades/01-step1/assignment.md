---
slug: step1
id: fuwubwmiqpfp
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    # Overview

    After completing this scenario, users will be able to upgrade from one major version of Red Hat Enterprise Linux to the next. (Example RHEL 7 to RHEL 8)

    ## Concepts included in this scenario:

    * Run pre-upgrade analysis and troubleshoot
    * Perform an in-place upgrade with LEAPP

    ## Example Usecase:

    A Systems Administrator needs to upgrade deployed Red Hat Enterprise Linux servers from their current version to the next major version to take advantage of a longer lifecycle and new features without needing to perform a clean install.

    For additional information refer to the leapp tool's documentation:
    https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index

    Note: This process works similarly for RHEL 8 and 9.
tabs:
- title: rhel
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1800
---
# What is Leapp?

Red Hat Leapp provides existing Red Hat Enterprise Linux 7 and 8 instances to upgrade from one major version to the next. This can be done on a one-to-one basis or en mass with a tool like Satellite. The Leapp tooling also includes a pre-upgrade assistant that makes it easy to identify breaking changes or warn about potential issues before any lasting changes are made to the system.

Before diving in, the question you have to ask is: is this workload worth executing a rebuild from scratch? That process can be tedious and time consuming. Doing an in-place upgrade retains the subscription, installed packages, user data, and configurations all while saving the time and resources required to deploy fresh.

# Installing Leapp

To get started, it is highly recommended that you update all packages on your system to the latest version available. (Note: for this lab, updates have already been run for you.)

Leapp is a supported operation for RHEL which means support tickets can be opened in case obstacles are encountered. It also means that the leapp utility is available straight from the Red Hat package repository. First, verify the version of Red Hat Enterprise Linux that you have installed:

```
cat /etc/redhat-release
```

<pre class=file>
# cat /etc/redhat-release
Red Hat Enterprise Linux release 7.9 (Maipo)
</pre>

Use the DNF package manager to install leapp and its dependencies:

```
dnf install -y leapp-upgrade
```

<pre class=file>
# dnf install leapp-upgrade
Red Hat Enterprise Linux 7 Server - Supplementary from RHUI (Debug RPMs)                                                                                                           5.5 kB/s | 512  B     00:00
Red Hat Enterprise Linux 7 Server - Optional from RHUI (RPMs)                                                                                                                       62 MB/s |  44 MB     00:00

... output truncated ...

Installing:
 leapp-upgrade-el7toel8                                   noarch                              0.16.0-8.el7_9                                rhui-rhel-7-server-rhui-extras-rpms                              781 k
Installing dependencies:
 leapp-deps                                               noarch                              0.14.0-1.el7_9                                rhui-rhel-7-server-rhui-extras-rpms                              9.9 k
 python2-leapp                                            noarch                              0.14.0-1.el7_9                                rhui-rhel-7-server-rhui-extras-rpms                              168 k
 leapp                                                    noarch                              0.14.0-1.el7_9                                rhui-rhel-7-server-rhui-extras-rpms                               27 k
 leapp-upgrade-el7toel8-deps                              noarch                              0.16.0-8.el7_9                                rhui-rhel-7-server-rhui-extras-rpms                               25 k
 pciutils                                                 x86_64                              3.5.1-3.el7                                   rhui-rhel-7-server-rhui-rpms                                      93 k

Transaction Summary
===================================================================================================================================================================================================================
Install  6 Packages

... output truncated ...

Installed:
  leapp-upgrade-el7toel8-0.16.0-8.el7_9.noarch    leapp-deps-0.14.0-1.el7_9.noarch    python2-leapp-0.14.0-1.el7_9.noarch    leapp-0.14.0-1.el7_9.noarch    leapp-upgrade-el7toel8-deps-0.16.0-8.el7_9.noarch
  pciutils-3.5.1-3.el7.x86_64

Complete!
</pre>

Verify the install was successful:

```
leapp --version
```

<pre class=file>
# leapp --version
leapp version 0.14.0
</pre>