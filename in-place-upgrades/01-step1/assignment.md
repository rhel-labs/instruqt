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

    For additional information refer to the leapp tool's documentation:
    https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index

    ## Example Usecase:

    A Systems Administrator needs to upgrade deployed Red Hat Enterprise Linux servers from their current version to the next major version to take advantage of a longer lifecycle and new features without needing to perform a clean install.

    Note: This process works similarly for RHEL 8 and 9.
tabs:
- title: rhel
  type: terminal
  hostname: host
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

First, you need to enable the rhel-7-server repositories using the subscription-manager command:

```
subscription-manager repos --enable rhel-7-server-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
```

Tip: You can actually combine these two commands into one!

<pre class=file>
# subscription-manager repos --enable rhel-7-server-rpms --enable rhel-7-server-extras-rpms
Repository 'rhel-7-server-rpms' is enabled for this system.
Repository 'rhel-7-server-extras-rpms' is enabled for this system.
</pre>

Next, use the DNF package manager to install leapp and its dependencies:

```
dnf install -y leapp-upgrade
```

<pre class=file>
# dnf install -y leapp-upgrade
Last metadata expiration check: 0:05:16 ago on Tue 30 Aug 2022 05:23:46 PM UTC.
Dependencies resolved.
===================================================================================================================================================================================================================
 Package                                                     Arch                                   Version                                        Repository                                                 Size
===================================================================================================================================================================================================================
Installing:
 leapp-upgrade-el7toel8                                      noarch                                 0.16.0-8.el7_9                                 rhel-7-server-extras-rpms                                 781 k
Installing dependencies:
 pciutils                                                    x86_64                                 3.5.1-3.el7                                    rhel-7-server-rpms                                         93 k
 leapp-deps                                                  noarch                                 0.14.0-1.el7_9                                 rhel-7-server-extras-rpms                                 9.9 k
 python2-leapp                                               noarch                                 0.14.0-1.el7_9                                 rhel-7-server-extras-rpms                                 168 k
 leapp                                                       noarch                                 0.14.0-1.el7_9                                 rhel-7-server-extras-rpms                                  27 k
 leapp-upgrade-el7toel8-deps                                 noarch                                 0.16.0-8.el7_9                                 rhel-7-server-extras-rpms                                  25 k


... output truncated ...

Running transaction
  Preparing        :                                                                                                                                                                                           1/1
  Installing       : leapp-deps-0.14.0-1.el7_9.noarch                                                                                                                                                          1/6
  Installing       : python2-leapp-0.14.0-1.el7_9.noarch                                                                                                                                                       2/6
  Installing       : pciutils-3.5.1-3.el7.x86_64                                                                                                                                                               3/6
  Installing       : leapp-upgrade-el7toel8-deps-0.16.0-8.el7_9.noarch                                                                                                                                         4/6
  Installing       : leapp-0.14.0-1.el7_9.noarch                                                                                                                                                               5/6
  Installing       : leapp-upgrade-el7toel8-0.16.0-8.el7_9.noarch                                                                                                                                              6/6
  Verifying        : pciutils-3.5.1-3.el7.x86_64                                                                                                                                                               1/6
  Verifying        : leapp-deps-0.14.0-1.el7_9.noarch                                                                                                                                                          2/6
  Verifying        : python2-leapp-0.14.0-1.el7_9.noarch                                                                                                                                                       3/6
  Verifying        : leapp-0.14.0-1.el7_9.noarch                                                                                                                                                               4/6
  Verifying        : leapp-upgrade-el7toel8-0.16.0-8.el7_9.noarch                                                                                                                                              5/6
  Verifying        : leapp-upgrade-el7toel8-deps-0.16.0-8.el7_9.noarch                                                                                                                                         6/6

Installed:
  leapp-upgrade-el7toel8-0.16.0-8.el7_9.noarch             pciutils-3.5.1-3.el7.x86_64        leapp-deps-0.14.0-1.el7_9.noarch        python2-leapp-0.14.0-1.el7_9.noarch        leapp-0.14.0-1.el7_9.noarch
  leapp-upgrade-el7toel8-deps-0.16.0-8.el7_9.noarch

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