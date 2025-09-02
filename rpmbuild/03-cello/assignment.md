---
slug: cello
id: wdtd6g26f8ey
type: challenge
title: Packaging cello
teaser: In this challenge, you will package cello, a program written in C.
tabs:
- id: fsw97iwwyatr
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: sudo -iu rhel
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Packaging cello

Your next challenge is to package **cello**, a program written in C.
Because this program must be compiled from source,
this spec file will have some notable differences from the previous one.

Expand the section headers below to work on each section of this challenge.

Obtaining the source files
===

Navigate to the **rpmbuild** directory.

```bash
cd rpmbuild
```

The source code archive for **cello** is located at **~/downloads/cello-1.0.tar.gz** on your system.
There is also a patch file located at **~/downloads/cello-output-first-patch.patch** that you will include in the package.
This patch will change the output of the program from the default "Hello World!" to "Hello World from my very first patch!".
You will be able to observe this output after you build and install the package.
Move these source files into the **SOURCES** directory.

```bash
mv -v ~/downloads/cello-1.0.tar.gz ~/downloads/cello-output-first-patch.patch SOURCES/
```
```nocopy
renamed '/home/rhel/downloads/cello-1.0.tar.gz' -> 'SOURCES/cello-1.0.tar.gz'
renamed '/home/rhel/downloads/cello-output-first-patch.patch' -> 'SOURCES/cello-output-first-patch.patch'
```

Verify the source code archive and patch file are in the correct location.

```bash
ls SOURCES/cello*
```
```nocopy
SOURCES/cello-1.0.tar.gz  SOURCES/cello-output-first-patch.patch
```

Expand the next section header to continue the challenge.

Writing the spec file
===

Here is a table of some of the additional preamble tags we will use in this spec file and their purpose.

| Tag | Use |
| -------- | -------- |
| Patch | file name or URL of patch to apply to the source code |
| BuildRequires | packages that must be installed prior to building this package |

Define the **NVR** (**Name**, **Version**, **Release**) of the package.
For now, set the version to **0**, even though this does not match the version of the software.
You will set this to the correct version in a future step.

```bash
cat >> SPECS/cello.spec << EOF
Name:           cello
Version:        0
Release:        1%{?dist}
EOF
```

Next, define the **Summary**, **License**, and **URL** of the software.
Define **Source** as the link where one may download the source code archive if they did not have it,
making sure the last segment matches our source code archive filename.
Define **Patch** as the patch file name.
Add build requirements for **gcc** and **make** since these will be needed to build the software.
Unlike the **bello** spec file,
you will **not** define **BuildArch** as **noarch**.
This is because this application is natively compiled for specific architectures.
**BuildArch** will be automatically defined based on the architecture of the machine you build the package on.

```bash
cat >> SPECS/cello.spec << EOF
Summary:        Hello World example implemented in C
License:        GPLv3+
URL:            https://github.com/redhat-developer/rpm-packaging-guide
Source:         %{url}/raw/master/example-code/cello-%{version}.tar.gz
Patch:          cello-output-first-patch.patch
BuildRequires:  gcc
BuildRequires:  make
EOF
```

The last part of the preamble is **%description**.

Add a sentence describing the software included in the package.

```bash
cat >> SPECS/cello.spec << EOF

%description
The long description for our Hello World Example implemented in C.
EOF
```

This completes the preamble of the spec file.

The next part of the spec file is **%prep**.
This is used to perform any steps needed to prepare the source code for building the software.

Add the **%autosetup** macro,
which will extract the source code archive and apply the patch file defined in the preamble.

```bash
cat >> SPECS/cello.spec << EOF

%prep
%autosetup
EOF
```

The next part of the spec file is **%build**.
This is used to perform any steps needed to build the software.

While **bello** in the previous challenge did not need to be compiled,
the same is not true for **cello**.
Its source code must be compiled into an executable binary.
This is done with the **make** command, which uses instructions from **cello**'s Makefile.

Add the **%make_build** macro,
which will run the **make** command with packaging-specific options.

```bash
cat >> SPECS/cello.spec << EOF

%build
%make_build
EOF
```

The next part of the spec file is **%install**.
This is used to perform any steps needed to place files and directories into the appropriate locations,
relative to the **%{buildroot}**.

Add the **%make_install** macro,
which will run the **make install** command with packaging-specific options.
This will copy files into the **%{buildroot}**.

```bash
cat >> SPECS/cello.spec << EOF

%install
%make_install
EOF
```

The next part of the spec file is **%files**.
Here you will create a manifest of what files are included in your package.

Add the **LICENSE** file with the **%license** attribute.

You will also list the rest of the files that are expected to be on the target system,
based on the contents of the **%{buildroot}**.
In this case that is just the **cello** executable in **/usr/bin**.

```bash
cat >> SPECS/cello.spec << EOF

%files
%license LICENSE
%{_bindir}/cello
EOF
```

The last part of the spec file is **%changelog**.
It lists the changes that have happened to the package between different versions and releases.

Leave this empty for now.

```bash
cat >> SPECS/cello.spec << EOF

%changelog
EOF
```

Use the **rpmdev-bumpspec** tool to create a changelog entry.
This tool will also change the **Version** field in the preamble to the correct value.

```bash
rpmdev-bumpspec --new 1.0 --comment 'Initial package' SPECS/cello.spec
```

Review the spec file you have written.

```bash
cat SPECS/cello.spec
```
```nocopy
Name:           cello
Version:        1.0
Release:        1%{?dist}
Summary:        Hello World example implemented in C
License:        GPLv3+
URL:            https://github.com/redhat-developer/rpm-packaging-guide
Source:         %{url}/raw/master/example-code/cello-%{version}.tar.gz
Patch:          cello-output-first-patch.patch
BuildRequires:  gcc
BuildRequires:  make

%description
The long description for our Hello World Example implemented in C.

%prep
%autosetup

%build
%make_build

%install
%make_install

%files
%license LICENSE
%{_bindir}/cello

%changelog
* Fri Jan 26 2024 First Last <first@example.com> - 1.0-1
- Initial package

```

Expand the next section header to continue the challenge.

Building the package
===

Before starting the **rpmbuild** process,
use the **rpmlint** command to check for common problems in your spec file.

```bash
rpmlint SPECS/cello.spec
```
```nocopy
0 packages and 1 specfiles checked; 0 errors, 0 warnings.
```

Because this package has build requirements defined in the preamble,
you must install them before building the package.

Install the build requirements with the **dnf builddep** command.

```bash
sudo dnf -y builddep SPECS/cello.spec
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 gcc                  x86_64   11.4.1-3.el9   rhel-9-for-x86_64-appstream-rpms    32 M
 make                 x86_64   1:4.3-8.el9    rhel-9-for-x86_64-baseos-rpms      541 k
Installing dependencies:
 annobin              x86_64   12.31-2.el9    rhel-9-for-x86_64-appstream-rpms   1.0 M
 cpp                  x86_64   11.4.1-3.el9   rhel-9-for-x86_64-appstream-rpms    11 M
 gcc-plugin-annobin   x86_64   11.4.1-3.el9   rhel-9-for-x86_64-appstream-rpms    49 k
 glibc-devel          x86_64   2.34-100.el9   rhel-9-for-x86_64-appstream-rpms    50 k
 glibc-headers        x86_64   2.34-100.el9   rhel-9-for-x86_64-appstream-rpms   555 k
### OUTPUT ABRIDGED ###
```

Once the build requirements are installed, you can build the package using the **rpmbuild** command.
This will create a package and a source package in the appropriate directories in your packaging workspace.
Because this package contains a compiled binary,
special debug packages (**cello-debuginfo** and **cello-debugsource**) will also be created.
You can ignore these during this lab.

```bash
rpmbuild -ba SPECS/cello.spec
```
```nocopy
### OUTPUT ABRIDGED ###
Wrote: /home/rhel/rpmbuild/SRPMS/cello-1.0-1.el9.src.rpm
Wrote: /home/rhel/rpmbuild/RPMS/x86_64/cello-debuginfo-1.0-1.el9.x86_64.rpm
Wrote: /home/rhel/rpmbuild/RPMS/x86_64/cello-1.0-1.el9.x86_64.rpm
Wrote: /home/rhel/rpmbuild/RPMS/x86_64/cello-debugsource-1.0-1.el9.x86_64.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.HECHUO
+ umask 022
+ cd /home/rhel/rpmbuild/BUILD
+ cd cello-1.0
+ /usr/bin/rm -rf /home/rhel/rpmbuild/BUILDROOT/cello-1.0-1.el9.x86_64
+ RPM_EC=0
++ jobs -p
+ exit 0
```

You can inspect these packages using the **rpm** and **rpmlint** commands.

Use the **rpm** command to list the contents of the source package.
In addition to the spec file and source code archive,
the patch file is also included.

```bash
rpm --query --list --package SRPMS/cello-1.0-1.el9.src.rpm
```
```nocopy
cello-1.0.tar.gz
cello-output-first-patch.patch
cello.spec
```

Use the **rpm** command to list the contents of the package.
Because this package contains a compiled binary,
it will include some additional files and directories under **/usr/lib/.build-id** that were added automatically.

```bash
rpm --query --list --package RPMS/x86_64/cello-1.0-1.el9.x86_64.rpm
```
```nocopy
/usr/bin/cello
/usr/lib/.build-id
/usr/lib/.build-id/02
/usr/lib/.build-id/02/b01f3ddde0567897e80bb2ffd0172dd444e404
/usr/share/licenses/cello
/usr/share/licenses/cello/LICENSE
```

Use the **rpmlint** command to check for common problems in the package.
You will see warnings about **no-documentation** and **no-manual-page-for-binary**.
These warnings are expected in this case because the **cello** software did not include any documentation files or a man page.

```bash
rpmlint RPMS/x86_64/cello-1.0-1.el9.x86_64.rpm
```
```nocopy
cello.x86_64: W: no-documentation
cello.x86_64: W: no-manual-page-for-binary cello
1 packages and 0 specfiles checked; 0 errors, 2 warnings.
```

Now that your package is built, you can install it on the system.

```bash
sudo dnf -y install RPMS/x86_64/cello-1.0-1.el9.x86_64.rpm
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 cello         x86_64         1.0-1.el9          @commandline          11 k
 ### OUTPUT ABRIDGED ###
```

Finally, run the **cello** program.
Notice how the output includes the modified message from our patch file.
If you built this package again without the patch file,
the output would be "Hello World!" instead.

```bash
cello
```
```nocopy
Hello World from my very first patch!
```

That concludes this challenge.
In the next challenge, you will be packaging a Python program named **pello**.