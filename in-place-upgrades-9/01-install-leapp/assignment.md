---
slug: install-leapp
id: cvway6cd669m
type: challenge
title: Installing Leapp
notes:
- type: text
  contents: |
    # Overview

    After completing this scenario, users will be able to upgrade from one major version of Red Hat Enterprise Linux 8 to 9.latest

    ## Concepts included in this scenario:

    * Run pre-upgrade analysis and troubleshoot
    * Perform an in-place upgrade with LEAPP

    For additional information refer to the leapp tool's documentation:
    https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index

    ## Example Usecase:

    A Systems Administrator needs to upgrade deployed Red Hat Enterprise Linux servers from their current version to the next major version to take advantage of a longer lifecycle and new features without needing to perform a clean install.

    Note: Curious about performing a RHEL 7 upgrade? https://www.redhat.com/en/interactive-labs/perform-in-place-upgrade-with-leapp
tabs:
- title: RHEL
  type: terminal
  hostname: host
difficulty: basic
timelimit: 3400
---
# What is Leapp?

Red Hat's leapp tool provides existing Red Hat Enterprise Linux instances to an upgrade path from one major version to the next. This can be done on a one-to-one basis or en mass with a tool like Satellite. The Leapp tooling also includes a pre-upgrade assistant that makes it easy to identify breaking changes or warn about potential issues before any lasting changes are made to the system.

Before diving in, the question you have to ask is: is this workload worth executing a rebuild from scratch? That process can be tedious and time consuming. Doing an in-place upgrade retains the subscription, installed packages, user data, and configurations all while saving the time and resources required to deploy fresh.

# Installing Leapp

To get started, it is highly recommended that you update all packages on your system to the latest version available. (Note: for this lab, updates have already been run for you.)

Leapp is a supported operation for RHEL which means support tickets can be opened in case obstacles are encountered. It also means that the leapp utility is available straight from the Red Hat package repository. First, verify the version of Red Hat Enterprise Linux that you have installed:

```
cat /etc/redhat-release

```

<pre class=file>
# cat /etc/redhat-release
Red Hat Enterprise Linux release 8.8 (Ootpa)
</pre>

Sinc you are already running a properly registered RHEL machine, you do not need to enable any additional repositories. Instead, simply use the DNF package manager to install leapp and its dependencies:

```
dnf install -y leapp-upgrade

```

<pre class=file>
# dnf install -y leapp-upgrade
Updating Subscription Management repositories.
Last metadata expiration check: 0:00:20 ago on Mon 12 Jun 2023 12:31:30 PM EDT.
Dependencies resolved.
============================================================================================================================================
 Package                           Architecture Version                                        Repository                              Size
============================================================================================================================================
Installing:
 leapp-upgrade-el8toel9            noarch       0.18.0-1.el8                                   rhel-8-for-x86_64-appstream-rpms       829 k
Installing dependencies:
 leapp                             noarch       0.15.1-1.el8                                   rhel-8-for-x86_64-appstream-rpms        33 k
 leapp-deps                        noarch       0.15.1-1.el8                                   rhel-8-for-x86_64-appstream-rpms        15 k
 leapp-upgrade-el8toel9-deps       noarch       0.18.0-1.el8                                   rhel-8-for-x86_64-appstream-rpms        35 k
 python3-leapp                     noarch       0.15.1-1.el8                                   rhel-8-for-x86_64-appstream-rpms       178 k
 python3-pip                       noarch       9.0.3-22.el8                                   rhel-8-for-x86_64-appstream-rpms        20 k -Junn-23
 python3-setuptools                noarch       39.2.0-7.el8                                   rhel-8-for-x86_64-baseos-rpms          163 k
 python36                          x86_64       3.6.8-38.module+el8.5.0+12207+5c5719bc         rhel-8-for-x86_64-appstream-rpms        19 k
 systemd-container                 x86_64       239-74.el8_8                                   rhel-8-for-x86_64-baseos-rpms          772 k
Enabling module streams:
 python36                                       3.6

Transaction Summary
============================================================================================================================================
Install  9 Packages

... output truncated ...

Installed:
  leapp-0.15.1-1.el8.noarch                                      leapp-deps-0.15.1-1.el8.noarch
  leapp-upgrade-el8toel9-0.18.0-1.el8.noarch                     leapp-upgrade-el8toel9-deps-0.18.0-1.el8.noarch
  python3-leapp-0.15.1-1.el8.noarch                              python3-pip-9.0.3-22.el8.noarch
  python3-setuptools-39.2.0-7.el8.noarch                         python36-3.6.8-38.module+el8.5.0+12207+5c5719bc.x86_64
  systemd-container-239-74.el8_8.x86_64

Complete!
</pre>

Verify the install was successful:

```
leapp --version

```

<pre class=file>
# leapp --version
leapp version 0.15.1
</pre>