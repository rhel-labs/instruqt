---
slug: introduction
type: challenge
title: Introduction to the Lab
teaser: Lean about this lab.
notes:
- type: text
  contents: Learn about this lab.
tabs:
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3360
---
blah blah blah

# Configure a system for Extended Update Support (EUS)

What is Extended Update Support?
EUS is an optional offering for Red Hat Enterprise Linux (RHEL) subscribers. With EUS, Red Hat provides backports of Critical and Important impact1 security updates and urgent-priority bug fixes for a predefined set of minor releases of Red Hat Enterprise Linux. EUS enables customers to remain with the same minor release of Red Hat Enterprise Linux for 24 months, allowing for stable production environments for mission-critical applications.

(Source: https://access.redhat.com/articles/rhel-eus)

First, you will need to verify the version of RHEL we are running:

```
cat /etc/redhat-release
```

<pre class=file>
# cat /etc/redhat-release
Red Hat Enterprise Linux release 8.6 (Ootpa)
</pre>

In order to see which releases are available for your system's current operating system, you will use the `subscription-manager` command:

```
subscription-manager release --list
```

<pre class=file>
# sudo subscription-manager release --list
+-------------------------------------------+
          Available Releases
+-------------------------------------------+
8
8.0
8.1
8.2
8.3
8.4
8.5
8.6
</pre>

Next, enable the EUS-specific repositories and disable the regular repositories:

```
subscription-manager repos --enable rhel-8-for-x86_64-baseos-eus-rpms --enable rhel-8-for-x86_64-appstream-eus-rpms
```

<pre class=file>
Repository 'rhel-8-for-x86_64-baseos-eus-rpms' is enabled for this system.
Repository 'rhel-8-for-x86_64-appstream-eus-rpms' is enabled for this system.
</pre>

```
subscription-manager repos --disable rhel-8-for-x86_64-baseos-rpms --disable rhel-8-for-x86_64-appstream-rpms
```

<pre class=file>
Repository 'rhel-8-for-x86_64-baseos-rpms' is disabled for this system.
Repository 'rhel-8-for-x86_64-appstream-rpms' is disabled for this system.
</pre>

With the latest EUS repositories configured, you will need to update all packages to their latest version before proceeding with the in-place upgrade:

```
dnf clean all
dnf update -y
```

Note: Your system's output may vary slightly from the example:

<pre class=file>
# dnf clean all
Updating Subscription Management repositories.
27 files removed

Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - AppStream(RPMs)       53 MB/s |  45 MB     00:00
Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support (RPMs)
...
Complete!
</pre>