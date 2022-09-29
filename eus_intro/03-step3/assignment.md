---
slug: step3
id: sp6femphn2qm
type: challenge
title: Introduction to Extended Update Support
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1140
---
# Upgrading between EUS releases

While EUS versions are supported for 24 months, it is a good practice to stay on as current a release as possible. Moving between minor releases is the best practice. However, some environments require recertification or are running software that the vendor only certifies specific minor releases of Red Hat Enterprise Linux. In those circumstances, upgrading between EUS releases is the necessary balance.

You will use the `subscription-manager` command to specify which version of RHEL your server will need to use:

```
subscription-manager release
```

<pre class=file>
Release not set
</pre>

Notice that your server currently doesn't have a release version specified. To correct that, you will need to manually specify a release:

```
subscription-manager release --set 8.6
```

<pre class=file>
Release set to: 8.6
</pre>

Now that our system has a specified minor version. You will be able to update your packages to the appropriate versions:

```
dnf clean all && dnf update -y
```

**Pro Tip**: It is encouraged to use the `clean all` option during these tasks as it forces dnf to clear existing metadata and pull down an updated listing for the new repositories.

<pre class=file>
Updating Subscription Management repositories.
17 files removed
Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - BaseOS - Extended Update Support (RPMs)                                                                                                     61 MB/s |  52 MB     00:00
Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support (RPMs)                                                                                                  72 MB/s |  47 MB     00:00
Last metadata expiration check: 0:00:08 ago on Thu 29 Sep 2022 09:56:46 PM UTC.

... Output Truncated ...

</pre>

Finally, verify that the update was successful:

```
cat /etc/redhat-release
```

<pre class=file>
Red Hat Enterprise Linux 8.6 (Ootpa)
</pre>
