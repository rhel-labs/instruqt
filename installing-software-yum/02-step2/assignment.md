---
slug: step2
id: rrse9imezbf8
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Updating a package

The `list` subcommand is useful for finding out which packages have available
updates on the system.

```
yum list updates
```

<pre class=file>
<< OUTPUT ABRIDGED >>
Available Upgrades
bash.x86_64              4.4.20-2.el8                               rhui-rhel-8-for-x86_64-baseos-rhui-rpms
chrony.x86_64            4.1-1.el8                                  rhui-rhel-8-for-x86_64-baseos-rhui-rpms
systemd.x86_64           239-51.el8_5.3                             rhui-rhel-8-for-x86_64-baseos-rhui-rpms
<< OUTPUT ABRIDGED >>
</pre>

Many packages on this system have updates available. Specifying a
package name with `yum update` will constrain this operation to only look
for that package.

>_NOTE:_ If you instead want to make sure your entire system is up to date,
running `yum update` without any other arguments apply updates for all
packages on your system (including YUM itself).

At the time of writing this lab, the __bash__ package required an update. Let's update __bash__. Use the `-y` option to automatically say yes to any prompts for the purposes of this lab.

Feel free to update any package listed.

```bash
yum -y update bash
```

<pre class=file>
<< OUTPUT ABRIDGED >>
===============================================================
 Package                Architecture       Size
===============================================================
Upgrading:
 bash                   x86_64             1.5 M

Transaction Summary
===============================================================
Upgrade  1 Package

<< OUTPUT ABRIDGED >>
</pre>

>_NOTE:_ You sometimes see the subcommand `upgrade` being used somewhat interchangeably with `update`. The difference between these two subcommands is that `upgrade` will remove any obsolete packages from the system. Often the configuration for YUM is such that these subcommands will both carry out the `upgrade` operation.

# Removing a package

Removing a package follows the same theme of simplicity.

```
yum -y remove httpd
```

The extensive output shows you information about which dependent RPMs were
removed as part of this transaction.

<pre class=file>
<< OUTPUT ABRIDGED >>
Removing:
 httpd            x86_64 2.4.37-39.module+el8.4.0+9658+b87b2deb

Removing dependent packages:
 mod_ssl          x86_64 1:2.4.37-39.module+el8.4.0+9658+b87b2deb

Removing unused dependencies:
 apr              x86_64 1.6.3-11.el8

<< OUTPUT ABRIDGED >>

Removed:
  httpd-2.4.37-39.module+el8.4.0+9658+b87b2deb.x86_64
  httpd-filesystem-2.4.37-39.module+el8.4.0+9658+b87b2deb.noarch
  httpd-tools-2.4.37-39.module+el8.4.0+9658+b87b2deb.x86_64

Complete!
</pre>

Use the `list` subcommand to confirm that the package has been uninstalled:

```
yum list httpd
```

<pre class=file>
<< OUTPUT ABRIDGED >>
Available Packages
httpd.x86_64 2.4.37-39.module+el8.4.0+9658+b87b2deb
</pre>

The package is now listed as _Available_ rather than _Installed_. The next
step will walk you through `yum history` which provides some more powerful
tools for rolling back package transactions.
