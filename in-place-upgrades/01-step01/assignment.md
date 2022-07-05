---
slug: step1
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to upgrade from one major version of Red Hat Enterprise Linux to the next. (Example RHEL 8 to RHEL 9)

    # Concepts included in this scenario:
    * Configure system for Extended Update Support (EUS) updates
    * Run pre-upgrade analysis and troubleshoot
    * Perform an in-place upgrade with LEAPP

    # Example Usecase:
    A Systems Administrator needs to upgrade deployed Red Hat Enterprise Linux servers from their current version to the latest major version to take advantage of a longer lifecycle and new features without needing to perform a clean install.

    For additional information refer to the leapp tool's documentation: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index

    Note: This process works similarly for RHEL 7 and 8.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1800
---
# Configure a system for Extended Update Support (EUS)

What is Extended Update Support? EUS is an optional offering for Red Hat Enterprise Linux (RHEL) subscribers. With EUS, Red Hat provides backports of Critical and Important impact1 security updates and urgent-priority bug fixes for a predefined set of minor releases of Red Hat Enterprise Linux. EUS enables customers to remain with the same minor release of Red Hat Enterprise Linux for 24 months, allowing for stable production environments for mission-critical applications. (Source: <a href="https://access.redhat.com/articles/rhel-eus">RHEL EUS Overview</a>)

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

Next, you will enable the EUS-specific repositories

```
subscription-manager repos --enable rhel-8-for-x86_64-baseos-eus-rpms --enable rhel-8-for-x86_64-appstream-eus-rpms
```

<pre class=file>
Repository 'rhel-8-for-x86_64-baseos-eus-rpms' is enabled for this system.
Repository 'rhel-8-for-x86_64-appstream-eus-rpms' is enabled for this system.
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
17 files removed

Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - AppStream(RPMs)       53 MB/s |  45 MB     00:00    
Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support (RPMs)
...
Complete!
</pre>