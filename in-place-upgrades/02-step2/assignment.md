---
slug: step2
id: cd0oxf4tyxwe
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1800
---
# Installing the leapp tool

Now that your system has all of its updates. It is now time to start the process towards an in-place upgrade. leapp is a supported operation for RHEL which means support tickets can be opened in case obstacles are encountered. It also means that the leapp utility is available in the Red Hat package repository. First, verify the version of Red Hat Enterprise Linux that you have installed:

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