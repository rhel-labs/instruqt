---
slug: converting-eus
id: 5jhbc4ugy0mh
type: challenge
title: Converting a System to EUS Repositories
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 2
---
Now that you have identified the most recent EUS version, you will need to disable the standard repositories and enable the EUS-specific repos.

## (Move to last step) **Pro Tip**: You can combine these two commands as shown below:
## (Add note: There are TWO repos that need EUS registration)

```
subscription-manager repos --disable rhel-8-for-x86_64-baseos-rpms --disable rhel-8-for-x86_64-appstream-rpms
```

<pre class=file>
Repository 'rhel-8-for-x86_64-baseos-rpms' is disabled for this system.
Repository 'rhel-8-for-x86_64-appstream-rpms' is disabled for this system.
</pre>

```
subscription-manager repos --enable rhel-8-for-x86_64-baseos-eus-rpms --enable rhel-8-for-x86_64-appstream-eus-rpms
```

## Add 8.4 to repo command

<pre class=file>
# subscription-manager repos --enable rhel-8-for-x86_64-baseos-eus-rpms --enable rhel-8-for-x86_64-appstream-eus-rpms
Repository 'rhel-8-for-x86_64-baseos-eus-rpms' is enabled for this system.
Repository 'rhel-8-for-x86_64-appstream-eus-rpms' is enabled for this system.
</pre>

With the latest EUS repositories configured, you will need to update all packages to their latest version before proceeding 

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
... Output Truncated ...
Complete!
</pre>

Now that we have the lastest packages availble in the EUS repositories, verify the minor version of RHEL:

```
cat /etc/redhat-release
```

<pre class=file>
Red Hat Enterprise Linux release 8.4 (Ootpa)
</pre>

Notice that with all the latest available packages installed, the server is still running RHEL 8.4. There is a newer EUS release available. In the next step, you will see how to upgrade between EUS versions.
