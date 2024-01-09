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
At this point, your system is not configured for EUS. If you were to run a `dnf update` with this configuration, you'd update to the latest version of RHEL 9. Since the standard 9.0 repositories are no longer live, you'll need to follow a couple extra steps, but first get an estimate of how many packages are available for update. This will be helpful to note for the remainder of this lab:

```
dnf list --updates| wc -l
```

<pre class=file>
# dnf list --updates| wc -l
393
</pre>

 The command above outputs a list of updates dnf finds then "pipes" it through the "word count" command to count the number of lines, giving you a rough estimate of the number of packages available. The command above tells you that to go from RHEL 9.0 proper to 9.3 latest will install about 393 new or updated packages.

 First, you will need to disable the standard repositories and enable the EUS-specific repos.

**Please note:** There are TWO repos that need to be unregistered. The baseos repo consists of all the packages essential for supporting the Linux Kernel, systemd, and other critical system functions. The AppStream (or Application Stream) repository houses workloads, like language libraries and databases. You will then re-register the EUS version of these repositories.

```
 subscription-manager repos --disable rhel-9-for-x86_64-baseos-rpms
 subscription-manager repos --disable rhel-9-for-x86_64-appstream-rpms

```

<pre class=file>
# subscription-manager repos --disable rhel-9-for-x86_64-baseos-rpms
Repository 'rhel-9-for-x86_64-baseos-rpms' is disabled for this system.
# subscription-manager repos --disable rhel-9-for-x86_64-appstream-rpms
Repository 'rhel-9-for-x86_64-appstream-rpms' is disabled for this system.
</pre>

Next, enable the EUS repositories.

**Pro Tip**: You can combine these two operations into a single command!

```
subscription-manager repos --enable rhel-9-for-x86_64-baseos-eus-rpms --enable rhel-9-for-x86_64-appstream-eus-rpms

```

<pre class=file>
# subscription-manager repos --enable rhel-9-for-x86_64-baseos-eus-rpms --enable rhel-9-for-x86_64-appstream-eus-rpms
Repository 'rhel-9-for-x86_64-baseos-eus-rpms' is enabled for this system.
Repository 'rhel-9-for-x86_64-appstream-eus-rpms' is enabled for this system.
</pre>

Now that your system has the EUS repositories enabled, in the next step, you will actually go through the process of updating packages from the EUS repo.