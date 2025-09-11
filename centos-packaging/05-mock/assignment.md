---
slug: mock
id: j1xooqpi9rrl
type: challenge
title: Building with mock
teaser: In this challenge, you will build packages with the mock tool.
tabs:
- id: xnkkcd4mexlv
  title: Terminal
  type: terminal
  hostname: centos
  cmd: sudo -iu centos
difficulty: ""
enhanced_loading: null
---
# Building with mock

Your final challenge is to build the **pello** package with **mock** instead of **rpmbuild**.
This will allow you to build a package that is compatible with CentOS Stream 10,
even though the build host is CentOS Stream 9.

This challenge uses files that you created during the **pello** challenge,
so if you skipped it you need to go back and complete it by clicking the "Progress" button in the top right.

Expand the section headers below to work on each section of this challenge.

Install and configure mock
===

Mock is not part of CentOS Stream.
It is available from the EPEL (Extra Packages for Enterprise Linux) repository.
Some packages in EPEL have dependencies from the CRB repository.

Use the **dnf config-manager** command to enable the CRB repository.

```bash
sudo dnf config-manager --set-enabled crb
```

Enable the EPEL repository.
This is accomplished by installing the **epel-release** package.

```bash
sudo dnf -y install epel-release
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 epel-release           noarch      9-7.el9        extras-common       19 k
Installing weak dependencies:
 epel-next-release      noarch      9-7.el9        extras-common      8.1 k
### OUTPUT ABRIDGED ###
```

Install the **mock** package from EPEL.

```bash
sudo dnf -y install mock
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 mock                noarch   5.5-1.el9        epel        210 k
Installing dependencies:
 acl                 x86_64   2.3.1-4.el9      baseos       71 k
 conmon              x86_64   3:2.1.10-2.el9   appstream    52 k
 containers-common   x86_64   2:1-61.el9       appstream   142 k
 cracklib            x86_64   2.9.6-27.el9     baseos       94 k
 cracklib-dicts      x86_64   2.9.6-27.el9     baseos      3.6 M
### OUTPUT ABRIDGED ###
```

In order to use **mock**,
a user must be a member of the **mock** group.

Use the **gpasswd** command to add the **centos** user to the **mock** group.

```bash
sudo gpasswd --add centos mock
```
```nocopy
Adding user centos to group mock
```

You can use the **groups** command to verify the group membership.

```bash
groups centos
```
```nocopy
centos : centos mock
```

Start a new login shell to have the new group membership take effect.

```bash
sudo -iu centos
```

Expand the next section header to continue the challenge.

Build with mock from a source package
===

Navigate to the **rpmbuild** directory.

```bash
cd rpmbuild
```

Use the **mock** command to build **pello** for CentOS Stream 10 from the previously built source package.
This will take a bit longer to run than the **rpmbuild** command,
because it must create the chroot environment.

```bash
mock --root centos-stream-10-x86_64 SRPMS/pello-1.0.4-1.el9.src.rpm
```
```nocopy
### OUTPUT ABRIDGED ###
Wrote: /builddir/build/RPMS/pello-1.0.4-1.el10.noarch.rpm
Finish: rpmbuild pello-1.0.4-1.el9.src.rpm
Finish: build phase for pello-1.0.4-1.el9.src.rpm
INFO: Done(SRPMS/pello-1.0.4-1.el9.src.rpm) Config(centos-stream-10-x86_64) 2 minutes 23 seconds
INFO: Results and/or logs in: /var/lib/mock/centos-stream-10-x86_64/result
Finish: run
```

The output from the last command shows the resulting packages are located in the **/var/lib/mock/centos-stream-10-x86_64/result** directory.

Use the **rpm** command to show the dependency on **python(abi)** in this package.
The version of this dependency corresponds to the default Python version (3.12) in CentOS Stream 10.

```bash
rpm --query --requires --package /var/lib/mock/centos-stream-10-x86_64/result/pello-1.0.4-1.el10.noarch.rpm | grep 'python(abi)'
```
```nocopy
python(abi) = 3.12
```

Now do the same for the package you built earlier with **rpmbuild**.
The version of this dependency corresponds to the default Python version (3.9) in CentOS Stream 9.

```bash
rpm --query --requires --package RPMS/noarch/pello-1.0.4-1.el9.noarch.rpm | grep 'python(abi)'
```
```nocopy
python(abi) = 3.9
```

Expand the next section header to continue the challenge.

Build with mock from a spec file
===

In addition to rebuilding source packages,
**mock** is also able to build directly from a spec file and the corresponding sources.
Before you do this, increment the **Release** in the **pello** spec file using **rpmdev-bumpspec**,
which will also add the appropriate changelog entry.

```bash
rpmdev-bumpspec --comment 'Rebuild' SPECS/pello.spec
```

Use **mock** to build **pello** for CentOS Stream 10 from the **pello** spec file and the **SOURCES** directory.
This will be a bit faster than the first time you ran **mock** thanks to the chroot being cached,
although still not quite as fast as running **rpmbuild** directly.

```bash
mock --root centos-stream-10-x86_64 --spec SPECS/pello.spec --sources SOURCES
```
```nocopy
### OUTPUT ABRIDGED ###
Wrote: /builddir/build/RPMS/pello-1.0.4-2.el10.noarch.rpm
Finish: rpmbuild pello-1.0.4-2.el10.src.rpm
Finish: build phase for pello-1.0.4-2.el10.src.rpm
INFO: Done(/var/lib/mock/centos-stream-10-x86_64/result/pello-1.0.4-2.el10.src.rpm) Config(centos-stream-10-x86_64) 0 minutes 8 seconds
INFO: Results and/or logs in: /var/lib/mock/centos-stream-10-x86_64/result
Finish: run
```

Use **rpm** to inspect the resulting package.

```bash
rpm --query --info --package /var/lib/mock/centos-stream-10-x86_64/result/pello-1.0.4-2.el10.noarch.rpm
```
```nocopy
Name        : pello
Version     : 1.0.4
Release     : 2.el10
Architecture: noarch
Install Date: (not installed)
Group       : Unspecified
Size        : 7359
License     : MIT
Signature   : (none)
Source RPM  : pello-1.0.4-2.el10.src.rpm
Build Date  : Fri 26 Jan 2024 07:50:11 AM UTC
Build Host  : localhost.localdomain
URL         : https://github.com/fedora-python/Pello
Summary     : An example Python Hello World package
Description :
Pello is an example package that will be used as a part of Fedora Python
Packaging Guidelines.  The only thing that this package does is printing
Hello World! on the command line.
```

That concludes this challenge,
which is the final challenge for this track.