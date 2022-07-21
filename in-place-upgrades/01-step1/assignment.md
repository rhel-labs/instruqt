---
slug: step1
id: fuwubwmiqpfp
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    # Overview

    After completing this scenario, users will be able to upgrade from one major version of Red Hat Enterprise Linux to the next. (Example RHEL 8 to RHEL 9)

    ## Concepts included in this scenario:

    * Run pre-upgrade analysis and troubleshoot
    * Perform an in-place upgrade with LEAPP

    ## Example Usecase:

    A Systems Administrator needs to upgrade deployed Red Hat Enterprise Linux servers from their current version to the latest major version to take advantage of a longer lifecycle and new features without needing to perform a clean install.

    For additional information refer to the leapp tool's documentation:
    https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index

    Note: This process works similarly for RHEL 7 and 8.
tabs:
- title: rhel
  type: terminal
  hostname: host1
- title: Host Web Console
  type: external
  url: https://host1.${_SANDBOX_ID}.instruqt.io:9090/machines#/vm/console?name=rhelvm&connection=system
difficulty: basic
timelimit: 1800
---
# What is Leapp?

Red Hat Leapp provides existing Red Hat Enterprise Linux 7 and 8 instances to upgrade from one major version to the next. This can be done on a one-to-one basis or en mass with a tool like Satellite. The Leapp tooling also includes a pre-upgrade assistant that makes it easy to identify breaking changes or warn about potential issues before any lasting changes are made to the system.

Before diving in, the question you have to ask is: is this workload worth executing a rebuild from scratch? That process can be tedious and time consuming. Doing an in-place upgrade retains the subscription, installed packages, user data, and configurations all while saving the time and resources required to deploy fresh.

# Installing Leapp

To get started, it is highly recommended that you update all packages on your system to the latest version available. Do a dnf update to make certain this is the case. (Note your output may vary.)

```
dnf update -y
```

<pre class=file>
# dnf update -y
Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)                                                                                                                                                          3.8 MB/s |  45 MB     00:11    
Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)                                                                                                                                                             4.2 MB/s |  49 MB     00:11    

... output truncated ...

</pre>

Now that your system has all of its updates, It is time to start the process towards an in-place upgrade. Leapp is a supported operation for RHEL which means support tickets can be opened in case obstacles are encountered. It also means that the leapp utility is available straight from the Red Hat package repository. First, verify the version of Red Hat Enterprise Linux that you have installed:

```
cat /etc/redhat-release
```

<pre class=file>
# cat /etc/redhat-release
Red Hat Enterprise Linux release 8.6 (Ootpa)
</pre>

Use the DNF package manager to install leapp and its dependencies:

```
dnf install -y leapp-upgrade
```

<pre class=file>
# dnf install leapp-upgrade
Updating Subscription Management repositories.
Last metadata expiration check: 0:17:05 ago on Tue 05 Jul 2022 11:34:56 AM EDT.
Dependencies resolved.
==============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================
 Package                                                                                                                      Architecture                                                                                            Version                                                                                                         Repository                                                                                                                         Size
==============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================
Installing:
 leapp-upgrade-el8toel9                                                                                                       noarch                                                                                                  0.16.0-6.el8_6                                                                                                  rhel-8-for-x86_64-appstream-rpms                                                                                                  603 k
Installing dependencies:
 leapp                                                                                                                        noarch                                                                                                  0.14.0-1.el8_6                                                                                                  rhel-8-for-x86_64-appstream-rpms                                                                                                   31 k
 leapp-deps                                                                                                                   noarch                                                                                                  0.14.0-1.el8_6                                                                                                  rhel-8-for-x86_64-appstream-rpms                                                                                                   14 k
 leapp-upgrade-el8toel9-deps                                                                                                  noarch                                                                                                  0.16.0-6.el8_6                                                                                                  rhel-8-for-x86_64-appstream-rpms                                                                                                   29 k
 python3-leapp                                                                                                                noarch                                                                                                  0.14.0-1.el8_6                                                                                                  rhel-8-for-x86_64-appstream-rpms                                                                                                  173 k

Transaction Summary
==============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================
Install  5 Packages

Total download size: 851 k
Installed size: 2.1 M
Downloading Packages:

... output truncated ...

Complete!
</pre>

Verify the install was successful

```
leapp --version
```

<pre class=file>
# leapp --version
leapp version 0.14.0
</pre>