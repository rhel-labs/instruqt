---
slug: step1
id: mn4dexksswet
type: challenge
title: Introduction to Extended Update Support
notes:
- type: text
  contents: |
    Whether you want more control over your lifecycle, need a longer support window, or are tied to a specific minor release, Extended Update Support (EUS) allows your Red Hat Enterprise Linux servers to stay on the same minor version for 2 years.

    # Tasks included in this scenario:
    * Identify current minor version and available versions of RHEL
    * Add EUS entitlement to a server
    * Update to the latest EUS release

    # Additional Reading:
    https://access.redhat.com/articles/rhel-eus
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1140
---
# What is Extended Update Support (EUS)?

EUS is an optional offering for Red Hat Enterprise Linux (RHEL) subscribers. With EUS, Red Hat provides backports of Critical and Important impact security updates and urgent-priority bug fixes for a predefined set of minor releases of Red Hat Enterprise Linux. EUS enables customers to remain with the same minor release of Red Hat Enterprise Linux for 24 months, allowing for stable production environments for mission-critical applications.

(Source: https://access.redhat.com/articles/rhel-eus)

# Preparing a system for EUS

In order to see which releases are available for your system's current operating system, you will use the `subscription-manager` command:

```
subscription-manager release --list
```

<pre class=file>
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
8.7
</pre>

Next, you will want to verify the version of RHEL we are running:

```
cat /etc/redhat-release
```

<pre class=file>
Red Hat Enterprise Linux release 8.4 (Ootpa)
</pre>
