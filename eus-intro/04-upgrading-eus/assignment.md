---
slug: upgrading-eus
id: sp6femphn2qm
type: challenge
title: Upgrading between EUS releases
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 2
---

TK = stay on 8.4 for up to 24 months, but how do you move forward?

While EUS versions are supported for 24 months, it is a good practice to stay on as current a release as possible. Moving between minor releases is the best practice. However, some environments require recertification or are running software that the vendor only certifies specific minor releases of Red Hat Enterprise Linux. In those circumstances, upgrading between EUS releases is the necessary balance.

```
dnf clean all && dnf update -y
```

**Pro Tip**: It is encouraged to use the `clean all` option during these tasks as it forces dnf to clear existing metadata and pull down an updated listing for the new repositories.

# Add unsubscribe / subscribe
# dnf list updates

<pre class=file>
Updating Subscription Management repositories.
17 files removed
Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - BaseOS - Extended Update Support (RPMs)                                                                                                     61 MB/s |  52 MB     00:00
Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support (RPMs)                                                                                                  72 MB/s |  47 MB     00:00
Last metadata expiration check: 0:00:08 ago on Thu 29 Sep 2022 09:56:46 PM UTC.
... Output Truncated ...
Complete
</pre>

Finally, verify that the update was successful:

```
cat /etc/redhat-release
```

<pre class=file>
Red Hat Enterprise Linux 8.6 (Ootpa)
</pre>
