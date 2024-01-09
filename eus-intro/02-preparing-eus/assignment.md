---
slug: preparing-eus
id: 2hfdpoj0iffh
type: challenge
title: Prepare a System for EUS repositories
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

# Preparing a system for EUS

Before you subscribe your system to an EUS release, it is important to note which release your system is running. This information is stored in the file `/etc/redhat-release`

```
cat /etc/redhat-release

```

<pre class=file>
Red Hat Enterprise Linux release 8.6 (Ootpa)
</pre>

At this point, your system is not configured for EUS. If you were to run a `dnf update` with this configuration, no packages would be available because the standard 8.6 repositories are no longer live.

```
dnf list --updates

```

<pre class=file>
# dnf list --updates
Updating Subscription Management repositories.
Last metadata expiration check: 0:00:17 ago on Thu 08 Jan 2024 11:29:05 PM UTC.
</pre>

In order to restore your system to a patchable state, you will need to disable the standard repositories and enable the EUS-specific repos.

**Please note:** There are TWO repos that need to be unregistered. The baseos repo consists of all the packages essential for supporting the Linux Kernel, systemd, and other critical system functions. The AppStream (or Application Stream) repository houses workloads, like language libraries and databases. You will then re-register the EUS version of these repositories.

```
subscription-manager repos --disable rhel-8-for-x86_64-baseos-rpms
subscription-manager repos --disable rhel-8-for-x86_64-appstream-rpms

```

<pre class=file>
# subscription-manager repos --disable rhel-8-for-x86_64-baseos-rpms
Repository 'rhel-8-for-x86_64-baseos-rpms' is disabled for this system.
# subscription-manager repos --disable rhel-8-for-x86_64-appstream-rpms
Repository 'rhel-8-for-x86_64-appstream-rpms' is disabled for this system.
</pre>

Next, enable the EUS repositories.

**Pro Tip**: You can combine these two operations into a single command!

```
subscription-manager repos --enable rhel-8-for-x86_64-baseos-eus-rpms --enable rhel-8-for-x86_64-appstream-eus-rpms

```

<pre class=file>
# subscription-manager repos --enable rhel-8-for-x86_64-baseos-eus-rpms --enable rhel-8-for-x86_64-appstream-eus-rpms
Repository 'rhel-8-for-x86_64-baseos-eus-rpms' is enabled for this system.
Repository 'rhel-8-for-x86_64-appstream-eus-rpms' is enabled for this system.
</pre>

Now that your system has the EUS repositories enabled, in the next step, you will actually go through the process of updating packages from the EUS repo.