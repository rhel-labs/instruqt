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
timelimit: 1
---

While EUS versions are supported for 24 months, it is a good practice to stay on as current a release as possible. However, some environments require recertification or are running software that the vendor only certifies for specific minor releases of Red Hat Enterprise Linux. In those circumstances, upgrading between EUS releases is the necessary balance.

In order to see which releases are available for your system's current major release, you will use the `subscription-manager` command:

```
subscription-manager release --list
```

<pre class=file>
# subscription-manager release --list
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

Before you upgrade to the lastest minor EUS release, it is worth noting that checks are built-in to ensure a system doesn't inadvertantly get updated to the absolute latest release. For instance, RHEL 8.7 is the current minor release but is _not_ an EUS release. Try setting 8.7 as the current release:

```
subscription-manager release --set=8.7
dnf clean all
dnf list --updates| wc -l

```

<pre class=file>
# subscription-manager release --set=8.7
Release set to: 8.7
# dnf clean all
Updating Subscription Management repositories.
17 files removed
# dnf list --updates| wc -l
Errors during downloading metadata for repository 'rhel-8-for-x86_64-baseos-eus-rpms':
  - Status code: 404 for https://cdn.redhat.com/content/eus/rhel8/8.7/x86_64/baseos/os/repodata/repomd.xml (IP: 2.16.212.251)
Error: Failed to download metadata for repo 'rhel-8-for-x86_64-baseos-eus-rpms': Cannot download repomd.xml: Cannot download repodata/repomd.xml: All mirrors were tried
2
</pre>

You receive several errors indicating the requested content could not be found. Now, select the correct release and verify there are packages available for update:

```
subscription-manager release --set=8.6
dnf clean all
dnf list --updates| wc -l

```

<pre class=file>
# subscription-manager release --set=8.6
Release set to: 8.6
# dnf clean all
Updating Subscription Management repositories.
17 files removed
# dnf list --updates| wc -l
318
</pre>

(Note that 318 is an estimated number and may vary depending on the available packages at the time your lab was built.)

Now that you have the latest EUS release selected, run a dnf update:

```
dnf update -y

```

<pre class=file>
# dnf update -y
Updating Subscription Management repositories.
Last metadata expiration check: 0:01:57 ago on Thu 15 Dec 2022 11:22:41 PM UTC.
Dependencies resolved.
...Output Truncated...
Installed:
  NetworkManager-initscripts-updown-1:1.36.0-11.el8_6.noarch                      glibc-gconv-extra-2.28-189.5.el8_6.x86_64
  grub2-tools-efi-1:2.02-123.el8_6.8.x86_64                                       insights-client-3.1.7-7.el8_6.noarch
  kernel-4.18.0-372.36.1.el8_6.x86_64                                             kernel-core-4.18.0-372.36.1.el8_6.x86_64
  kernel-modules-4.18.0-372.36.1.el8_6.x86_64                                     libbpf-0.4.0-3.el8.x86_64
  python3-cloud-what-1.28.29-3.el8.x86_64                                         python3-magic-5.33-20.el8.noarch
  sqlite-3.26.0-16.el8_6.x86_64
Removed:
  kernel-4.18.0-305.el8.x86_64               kernel-core-4.18.0-305.el8.x86_64               kernel-modules-4.18.0-305.el8.x86_64

Complete!
</pre>

Finally, verify that the upgrade was successful:

```
cat /etc/redhat-release

```

<pre class=file>
Red Hat Enterprise Linux 8.6 (Ootpa)
</pre>
