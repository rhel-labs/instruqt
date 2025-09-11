---
slug: bello-build-rpm
id: p5qbx1rh2ggx
type: challenge
title: Packaging bello - Building and validating the RPM package
teaser: In this step, you will use the `rpmbuild` command to build your RPM package
  described in the SPEC file you wrote on the previous step.
tabs:
- id: tcrtdbtqnfc5
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: ""
timelimit: 1
enhanced_loading: null
---
Switch to the **rhel** user again.

```
sudo -iu rhel
```

Navigate to the **rpmbuild** directory.

```
cd rpmbuild
```

Before starting the **rpmbuild** process,
use the **rpmlint** command to check for common problems in your spec file.  "linting" your SPEC files is a recommended practice for package developers.

```
rpmlint SPECS/bello.spec
```
```txt,nocopy
0 packages and 1 specfiles checked; 0 errors, 0 warnings.
```

With a clean linting of your SPEC file, it is time to build the package with the **rpmbuild** command.
This will create a package and a source package in the appropriate directories in your packaging workspace.

```
rpmbuild -ba SPECS/bello.spec
```
```txt,nocopy
Wrote: /home/rhel/rpmbuild/SRPMS/bello-0.1-1.el9.src.rpm
Wrote: /home/rhel/rpmbuild/RPMS/noarch/bello-0.1-1.el9.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.ljskTE
+ umask 022
+ cd /home/rhel/rpmbuild/BUILD
+ cd bello-0.1
+ /usr/bin/rm -rf /home/rhel/rpmbuild/BUILDROOT/bello-0.1-1.el9.x86_64
+ RPM_EC=0
++ jobs -p
+ exit 0
```

You can inspect these packages using the **rpm** and **rpmlint** commands.

Use the **rpm** command to list the contents of the source package.
You'll notice this includes the spec file and source code archive.

```
rpm --query --list --package SRPMS/bello-0.1-1.el9.src.rpm
```
```txt,nocopy
bello-0.1.tar.gz
bello.spec
```

Use the **rpm** command to list the contents of the package.

```
rpm --query --list --package RPMS/noarch/bello-0.1-1.el9.noarch.rpm
```
```txt,nocopy
/usr/bin/bello
/usr/share/licenses/bello
/usr/share/licenses/bello/LICENSE
```

Use the **rpmlint** command to check for common problems in the package.
You will see warnings about **no-documentation** and **no-manual-page-for-binary**.
These warnings are expected in this case because **bello** did not include any documentation files or a man page.

```
rpmlint RPMS/noarch/bello-0.1-1.el9.noarch.rpm
```
```txt,nocopy
bello.noarch: W: no-documentation
bello.noarch: W: no-manual-page-for-binary bello
1 packages and 0 specfiles checked; 0 errors, 2 warnings.
```

Now that your package is built, you can install it on the system.
This system has been configured to allow the **rhel** user to run **sudo** without entering a password.

```
sudo dnf -y install RPMS/noarch/bello-0.1-1.el9.noarch.rpm
```
```txt,nocopy
### OUTPUT ABRIDGED ###
Installing:
 bello                                          noarch                                          0.1-1.el9                                            @commandline                                          7.6 k
### OUTPUT ABRIDGED ###
```

Finally, run the **bello** program.

```
bello
```
```txt,nocopy
Hello World
```

Congratulations on making an RPM package containing a bash "Hello World" program!