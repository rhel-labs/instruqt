---
slug: updating-release
id: sp6femphn2qm
type: challenge
title: Updating between EUS releases
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
You just performed updates within a minor release of RHEL, namely 9.0. When it comes time to move to a newer EUS release, you'll follow a similar process but specifying the later release:

```
subscription-manager release --set=9.2
dnf clean all
dnf list --updates| wc -l

```

<pre class=file>
# subscription-manager release --set=9.2
# dnf clean all
# dnf list --updates| wc -l
Release set to: 9.2
Updating Subscription Management repositories.
26 files removed
369
</pre>

Note that 369 is an estimated number and may vary depending on the available packages at the date you initiated this lab. Now that you have the latest EUS release selected, run a dnf update:

```
dnf update -y

```

<pre class=file>
# dnf update -y
Updating Subscription Management repositories.
Last metadata expiration check: 0:01:57 ago on Tue 09 Jan 2024 09:22:41 PM UTC.
Dependencies resolved.
...Output Truncated...
Installed:
  adobe-source-code-pro-fonts-2.030.1.050-12.el9.1.noarch           freetype-2.10.4-9.el9.x86_64
  graphite2-1.3.14-9.el9.x86_64                                     grub2-tools-efi-1:2.06-61.el9_2.1.x86_64
  grub2-tools-extra-1:2.06-61.el9_2.1.x86_64                        harfbuzz-2.7.4-8.el9.x86_64
  httpd-core-2.4.53-11.el9_2.5.x86_64                               kernel-5.14.0-284.40.1.el9_2.x86_64
  kernel-core-5.14.0-284.40.1.el9_2.x86_64                          kernel-modules-5.14.0-284.40.1.el9_2.x86_64
  kernel-modules-core-5.14.0-284.40.1.el9_2.x86_64                  libatomic-11.3.1-4.3.el9.x86_64
  python3-distro-1.5.0-7.el9.noarch                                 python3-file-magic-5.39-12.1.el9_2.noarch
  python3-gobject-base-noarch-3.40.1-6.el9.noarch                   python3-pyyaml-5.4.1-6.el9.x86_64

Complete!
</pre>

Finally, verify that the update was successful:

```
cat /etc/redhat-release

```

<pre class=file>
Red Hat Enterprise Linux 9.2 (Plow)
</pre>
