---
slug: eus-update
id: 5jhbc4ugy0mh
type: challenge
title: Updating within an EUS Release
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
9
9.0
9.1
9.2
9.3
</pre>

Before you upgrade to the lastest minor EUS release, it is worth noting that checks are built-in to ensure a system doesn't inadvertantly get updated to the absolute latest release. For instance, RHEL 9.3 is the current minor release but is _not_ an EUS release. Try setting 9.3 as the current release:

```
subscription-manager release --set=9.3
dnf clean all
dnf list --updates| wc -l

```

<pre class=file>
# subscription-manager release --set=9.3
Release set to: 9.3
# dnf clean all
Updating Subscription Management repositories.
27 files removed
# dnf list --updates| wc -l
Errors during downloading metadata for repository 'rhel-9-for-x86_64-baseos-eus-rpms':
  - Status code: 404 for https://cdn.redhat.com/content/eus/rhel8/8.7/x86_64/baseos/os/repodata/repomd.xml (IP: 2.16.212.251)
Error: Failed to download metadata for repo 'rhel-8-for-x86_64-baseos-eus-rpms': Cannot download repomd.xml: Cannot download repodata/repomd.xml: All mirrors were tried
2
</pre>

You receive several errors indicating the requested content could not be found. Now, select the correct release and verify there are packages available for update:

```
subscription-manager release --set=9.0
dnf clean all
dnf list --updates| wc -l

```

<pre class=file>
# dnf clean all
Updating Subscription Management repositories.
34 files removed
# dnf list --updates| wc -l
119
</pre>

Update your system to the latest packages in this EUS release:

```
dnf update -y

```

Note: Your system's output may vary slightly from the example:

<pre class=file>
# dnf update -y
Updating Subscription Management repositories.
Red Hat Enterprise Linux 9 for x86_64 - AppStream(RPMs)       53 MB/s |  45 MB     00:00
Red Hat Enterprise Linux 9 for x86_64 - AppStream - Extended Update Support (RPMs)
... Output Truncated ...
Installed:
  freetype-2.10.4-6.el9.x86_64                        graphite2-1.3.14-9.el9.x86_64
  grub2-tools-efi-1:2.06-27.el9_0.15.x86_64           grub2-tools-extra-1:2.06-27.el9_0.15.x86_64
  harfbuzz-2.7.4-5.el9.x86_64                         kernel-5.14.0-70.80.1.el9_0.x86_64
  kernel-core-5.14.0-70.80.1.el9_0.x86_64             kernel-modules-5.14.0-70.80.1.el9_0.x86_64
  python3-file-magic-5.39-8.el9.noarch                python3-pyyaml-5.4.1-6.el9.x86_64

Complete!
</pre>

Now that you have the lastest packages availble in this EUS repositories, verify the minor version of RHEL is the same as Step 2:

```
cat /etc/redhat-release

```

<pre class=file>
Red Hat Enterprise Linux release 9.0 (Plow)
</pre>

Notice that with all the latest available packages installed, the server is still running RHEL 9.0. There is a newer EUS release available. In the final step, you will see how to upgrade between EUS versions.
