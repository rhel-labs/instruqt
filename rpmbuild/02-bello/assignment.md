---
slug: bello
id: 2mrvvpdsg9et
type: challenge
title: Packaging bello
teaser: In this challenge, you will package bello, a program written in Bash.
tabs:
- id: 2b0wdijwq1rq
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: sudo -iu rhel
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Packaging bello

Your next challenge is to package **bello**, a program written in Bash.

Expand the section headers below to work on each section of this challenge.

Obtaining the source files
===

Navigate to the **rpmbuild** directory.

```bash
cd rpmbuild
```

The source code archive for **bello** is located at **~/downloads/bello-0.1.tar.gz** on your system.

Move the source code archive into the **SOURCES** directory.

```bash
mv -v ~/downloads/bello-0.1.tar.gz SOURCES/
```
```nocopy
renamed '/home/rhel/downloads/bello-0.1.tar.gz' -> 'SOURCES/bello-0.1.tar.gz'
```

Verify the source code archive is in the correct location.
The filename will be displayed in red text to indicate that it is a compressed file.

```bash
ls SOURCES/bello*
```
```nocopy
SOURCES/bello-0.1.tar.gz
```

Expand the next section header to continue the challenge.

Writing the spec file
===

Now you are going to create the spec file in the **SPECS** directory.
You will start with the **preamble**, where metadata about the package is defined.
The table below describes the preamble tags we are going to use for the **bello** package.

| Tag | Use |
| -------- | -------- |
| Name | name of the package, should match the spec file name |
| Version | version of the software being packaged |
| Release | used to distinguish between different builds of the same software version  |
| Summary | short one line summary of the package |
| License | identifier for the license that governs the use and distribution of the software |
| URL | homepage for the project or author of the software |
| Source | file name or URL of a file needed to build the software |
| BuildArch | CPU architecture on which this software is compiled to run |

Define the **Name**, **Version**, and **Release** of the package.
These properties together form a useful identifier known as the **NVR** (e.g. **bash-5.1.8-9.el9**).
For now, set the version to **0**, even though this does not match the version of the software.
You will set this to the correct version in a future step.

The command below uses what is called a "here document" to write the contents of the spec file.
If you like, you can write the same content to that file manually
with a command-line text editor such as vim or nano.

```bash
cat >> SPECS/bello.spec << EOF
Name:           bello
Version:        0
Release:        1%{?dist}
EOF
```

Next, define the **Summary**, **License**, and **URL** for the software.
Define **Source** as the link where one may download the source code archive if they did not already have it,
making sure the last segment matches our source code archive filename.
You'll note that in the **Source** below we use the **%{url}** macro,
which will expand to the value you set in the **URL** tag.
Define **BuildArch** as **noarch** to mark the package as architecture-independent.

You might think you need to add a **Requires** to indicate the software requires **bash**,
however, this dependency will be added automatically in the resulting package
because the **bello** script starts with a shebang line (**#!/bin/bash**).

```bash
cat >> SPECS/bello.spec << EOF
Summary:        Hello World example implemented in bash script
License:        GPLv3+
URL:            https://github.com/redhat-developer/rpm-packaging-guide
Source:         %{url}/raw/master/example-code/bello-%{version}.tar.gz
BuildArch:      noarch
EOF
```

The last part of the preamble is **%description**.
While the **Summary** is limited to one line,
the **%description** can be used to write a longer description of the package
that may span multiple lines if needed.

Add a sentence describing the software included in the package.

```bash
cat >> SPECS/bello.spec << EOF

%description
The long description for our Hello World Example implemented in bash script.
EOF
```

This completes the preamble of the spec file.

The next part of the spec file is **%prep**.
This is used to perform any steps needed to prepare the source code for building the software.

Add the **%autosetup** macro,
which will extract the source code archive.

```bash
cat >> SPECS/bello.spec << EOF

%prep
%autosetup
EOF
```

The next part of the spec file is **%build**.
This is used to perform any steps needed to build the software.

Because **bello** is a bash script,
there is nothing to compile.
This means that this part will be empty,
but it still needs to exist to avoid warnings.

```bash
cat >> SPECS/bello.spec << EOF

%build
EOF
```

The next part of the spec file is **%install**.
This is used to perform any steps needed to place files and directories into the appropriate locations,
relative to the **%{buildroot}**.

The command below will copy the **bello** script from the extracted sources into the **%{buildroot}**,
with the appropriate permissions and creating parent directories as needed.
The **%{\_bindir}** macro expands to **/usr/bin**,
which is where the script will be on a system that installs this package.

```bash
cat >> SPECS/bello.spec << EOF

%install
install -D -p -m 0755 bello %{buildroot}%{_bindir}/bello
EOF
```

The next part of the spec file is **%files**.
Here you will create a manifest of what files are included in your package.

Add the **LICENSE** file to this manifest,
with the special **%license** attribute.
Usually files here use absolute paths (relative to the **%{buildroot}**),
but in this case you will use just the filename.
This is because you haven't copied the **LICENSE** file from the extracted source code archive into the **%{buildroot}** yet.
The **%license** attribute will do that for you automatically,
copying the file into **/usr/share/licenses/bello** inside the **%{buildroot}**.

You will also list the rest of the files that are expected to be on the target system,
based on the contents of the **%{buildroot}**.
In this case that is just the **bello** script in **/usr/bin**.

```bash
cat >> SPECS/bello.spec << EOF

%files
%license LICENSE
%{_bindir}/bello
EOF
```

The last part of the spec file is **%changelog**.
It lists the changes that have happened to the package between different versions and releases.

Leave this empty for now.

```bash
cat >> SPECS/bello.spec << EOF

%changelog
EOF
```

Use the **rpmdev-bumpspec** tool to create a changelog entry.
This tool will also change the **Version** field in the preamble to the correct value.

```bash
rpmdev-bumpspec --new 0.1 --comment 'Initial package' SPECS/bello.spec
```

Review the spec file you have written.

```bash
cat SPECS/bello.spec
```
```nocopy
Name:           bello
Version:        0.1
Release:        1%{?dist}
Summary:        Hello World example implemented in bash script
License:        GPLv3+
URL:            https://github.com/redhat-developer/rpm-packaging-guide
Source:         %{url}/raw/master/example-code/bello-%{version}.tar.gz
BuildArch:      noarch

%description
The long description for our Hello World Example implemented in bash script.

%prep
%autosetup

%build

%install
install -D -p -m 0755 bello %{buildroot}%{_bindir}/bello

%files
%license LICENSE
%{_bindir}/bello

%changelog
* Fri Jan 26 2024 First Last <first@example.com> - 0.1-1
- Initial package

```

Expand the next section header to continue the challenge.

Building the package
===

Before starting the **rpmbuild** process,
use the **rpmlint** command to check for common problems in your spec file.

```bash
rpmlint SPECS/bello.spec
```
```nocopy
0 packages and 1 specfiles checked; 0 errors, 0 warnings.
```

With a clean linting of your SPEC file, it is time to build the package with the **rpmbuild** command.
This will create a package and a source package in the appropriate directories in your packaging workspace.

```bash
rpmbuild -ba SPECS/bello.spec
```
```nocopy
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

```bash
rpm --query --list --package SRPMS/bello-0.1-1.el9.src.rpm
```
```nocopy
bello-0.1.tar.gz
bello.spec
```

Use the **rpm** command to list the contents of the package.

```bash
rpm --query --list --package RPMS/noarch/bello-0.1-1.el9.noarch.rpm
```
```nocopy
/usr/bin/bello
/usr/share/licenses/bello
/usr/share/licenses/bello/LICENSE
```

Use the **rpmlint** command to check for common problems in the package.
You will see warnings about **no-documentation** and **no-manual-page-for-binary**.
These warnings are expected in this case because the **bello** software did not include any documentation files or a man page.

```bash
rpmlint RPMS/noarch/bello-0.1-1.el9.noarch.rpm
```
```nocopy
bello.noarch: W: no-documentation
bello.noarch: W: no-manual-page-for-binary bello
1 packages and 0 specfiles checked; 0 errors, 2 warnings.
```

Now that your package is built, you can install it on the system.

```bash
sudo dnf -y install RPMS/noarch/bello-0.1-1.el9.noarch.rpm
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 bello         noarch         0.1-1.el9          @commandline         7.6 k
### OUTPUT ABRIDGED ###
```

Finally, run the **bello** program.

```bash
bello
```
```nocopy
Hello World
```

That concludes this challenge.
In the next challenge, you will be packaging a C program named **cello**.