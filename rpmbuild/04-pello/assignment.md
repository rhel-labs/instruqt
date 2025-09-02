---
slug: pello
id: gcrtgmuwfezk
type: challenge
title: Packaging pello
teaser: In this challenge, you will package pello, a program written in Python.
tabs:
- id: t4e0cmfphd8a
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: sudo -iu rhel
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Packaging pello

Your next challenge is to package **pello**, a program written in Python.
This will be an architecture-independent (**noarch**) package like **bello**,
but it will also have files that need to be compiled to byte code.

Expand the section headers below to work on each section of this challenge.

Obtaining the source files
===

Navigate to the **rpmbuild** directory.

```bash
cd rpmbuild
```

The source code archive for pello is located at **~/downloads/Pello-1.0.4.tar.gz** on your system.
Move the source code archive into the **SOURCES** directory.

```bash
mv -v ~/downloads/Pello-1.0.4.tar.gz SOURCES/
```
```nocopy
renamed '/home/rhel/downloads/Pello-1.0.4.tar.gz' -> 'SOURCES/Pello-1.0.4.tar.gz'
```

Verify the source code archive is in the correct location.

```bash
ls SOURCES/Pello*
```
```nocopy
SOURCES/Pello-1.0.4.tar.gz
```

Expand the next section header to continue the challenge.

Writing the spec file
===

Define the **NVR** (**Name**, **Version**, **Release**) of the package.
For now, set the version to **0**, even though this does not match the version of the software.
You will set this to the correct version in a future step.

```bash
cat >> SPECS/pello.spec << EOF
Name:           pello
Version:        0
Release:        1%{?dist}
EOF
```

Next, define the **Summary**, **License**, and **URL** for the software.
**Pello** is available from the PyPI website,
so instead of defining **Source** directly you can use the **%pypi_source** macro to generate the link.
The last portion of this link (the file name) will match the source code archive located in **SOURCES**.
Define **BuildArch** to mark the package as architecture-independent.
Add build requirements for **python3-devel** and **python3-setuptools** since these will be needed to build the software.
Also add a build requirement for **python3-pytest**,
which will be used to run the upstream unit tests.

You might think you need to add a **Requires** to indicate this software requires **python3**,
but similar to **bello**'s dependency on **bash**,
this dependency will be added automatically.

```bash
cat >> SPECS/pello.spec << EOF
Summary:        An example Python Hello World package
License:        MIT
URL:            https://github.com/fedora-python/Pello
Source:         %{pypi_source Pello}
BuildArch:      noarch
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools
BuildRequires:  python3-pytest
EOF
```

The last part of the preamble is **%description**.

Add a few sentences describing the software included in the package.

```bash
cat >> SPECS/pello.spec << EOF

%description
Pello is an example package that will be used as a part of Fedora Python
Packaging Guidelines.  The only thing that this package does is printing
Hello World! on the command line.
EOF
```

This completes the preamble of the spec file.

The next part of the spec file is **%prep**.
This is used to perform any steps needed to prepare the source code for building the software.

Add the **%autosetup** macro,
which will extract the source code archive.
Note that you will need to use the **-n** flag to indicate that the top level directory of the source code archive
doesn't match the default **%{name}-%{version}** due to the capital P.

```bash
cat >> SPECS/pello.spec << EOF

%prep
%autosetup -n Pello-%{version}
EOF
```

The next part of the spec file is **%build**.
This is used to perform any steps needed to build the software.

**Pello** is an architecture-independent program,
but it does need to be compiled to byte code.

Add the **%py3_build** macro, which will run **python3 setup.py build** with packaging-specific options.

```bash
cat >> SPECS/pello.spec << EOF

%build
%py3_build
EOF
```

The next part of the spec file is **%install**.
This is used to perform any steps needed to place files and directories into the appropriate locations,
relative to the **%{buildroot}**.

Add the **%py3_install** macro,
which will run the **python3 setup.py install** command with packaging-specific options.
This will copy files into the **%{buildroot}**.

```bash
cat >> SPECS/pello.spec << EOF

%install
%py3_install
EOF
```

The next part of the spec file is **%check**.
This is used to perform any steps needed to validate the software functions correctly,
such as running the upstream unit tests.

Add the **%pytest** macro,
which will run the **pytest** command with packaging-specific options.

```bash
cat >> SPECS/pello.spec << EOF

%check
%pytest
EOF
```

The next part of the spec file is **%files**.
Here you will create a manifest of what files are included in your package.

Add the **LICENSE.txt** file with the **%license** attribute.
Similar to the **%license** attribute,
there is also a **%doc** attribute to mark files as documentation in the package metadata.
The notable difference between these attributes is that **dnf** can be configured to skip documentation files,
but license files must always be included.
Add the **README.md** file with the **%doc** attribute.

You will also list the rest of the files that are expected to be on the target system,
based on the contents of the **%{buildroot}**.
In addition to the **pello_greeting** file in **/usr/bin**,
you also need to list the files in the **%{python3_sitelib}**,
which expands to **/usr/lib/python3.9/site-packages**.
Note that you can use **\*** as a wildcard for paths that may be different
depending on which operating system the package is built for.

```bash
cat >> SPECS/pello.spec << EOF

%files
%license LICENSE.txt
%doc README.md
%{_bindir}/pello_greeting
%{python3_sitelib}/Pello-*.egg-info
%{python3_sitelib}/pello
EOF
```

The last part of the spec file is **%changelog**.
It lists the changes that have happened to the package between different versions and releases.

Leave this empty for now.

```bash
cat >> SPECS/pello.spec << EOF

%changelog
EOF
```

Use the **rpmdev-bumpspec** tool to create a changelog entry.
This tool will also change the **Version** field in the preamble to the correct value.

```bash
rpmdev-bumpspec --new 1.0.4 --comment 'Initial package' SPECS/pello.spec
```

Review the spec file you have written.

```bash
cat SPECS/pello.spec
```
```nocopy
Name:           pello
Version:        1.0.4
Release:        1%{?dist}
Summary:        An example Python Hello World package
License:        MIT
URL:            https://github.com/fedora-python/Pello
Source:         %{pypi_source Pello}
BuildArch:      noarch
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools
BuildRequires:  python3-pytest

%description
Pello is an example package that will be used as a part of Fedora Python
Packaging Guidelines.  The only thing that this package does is printing
Hello World! on the command line.

%prep
%autosetup -n Pello-%{version}

%build
%py3_build

%install
%py3_install

%check
%pytest

%files
%license LICENSE.txt
%doc README.md
%{python3_sitelib}/Pello-*.egg-info
%{python3_sitelib}/pello
%{_bindir}/pello_greeting

%changelog
* Fri Jan 26 2024 First Last <first@example.com> - 1.0.4-1
- Initial package

```

Expand the next section header to continue the challenge.

Building the package
===

Before starting the **rpmbuild** process,
use the **rpmlint** command to check for common problems in your spec file.

```bash
rpmlint SPECS/pello.spec
```
```nocopy
0 packages and 1 specfiles checked; 0 errors, 0 warnings.
```

Install the build requirements with the **dnf builddep** command.

```bash
sudo dnf -y builddep SPECS/pello.spec
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 python3-devel        x86_64   3.9.18-3.el9    rhel-9-for-x86_64-appstream-rpms           248 k
 python3-pytest       noarch   6.2.2-6.el9     codeready-builder-for-rhel-9-x86_64-rpms   525 k
Installing dependencies:
 python-rpm-macros    noarch   3.9-53.el9      rhel-9-for-x86_64-appstream-rpms            17 k
 python3-attrs        noarch   20.3.0-7.el9    rhel-9-for-x86_64-appstream-rpms            91 k
 python3-iniconfig    noarch   1.1.1-7.el9     codeready-builder-for-rhel-9-x86_64-rpms    21 k
 python3-packaging    noarch   20.9-5.el9      rhel-9-for-x86_64-appstream-rpms            81 k
 python3-pluggy       noarch   0.13.1-7.el9    codeready-builder-for-rhel-9-x86_64-rpms    45 k
### OUTPUT ABRIDGED ###
```

Once the build requirements are installed, you can build the package using the **rpmbuild** command.
This will create a package and a source package in the appropriate directories in your packaging workspace.

```bash
rpmbuild -ba SPECS/pello.spec
```
```nocopy
### OUTPUT ABRIDGED ###
Wrote: /home/rhel/rpmbuild/SRPMS/pello-1.0.4-1.el9.src.rpm
Wrote: /home/rhel/rpmbuild/RPMS/noarch/pello-1.0.4-1.el9.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.npnz0l
+ umask 022
+ cd /home/rhel/rpmbuild/BUILD
+ cd Pello-1.0.4
+ /usr/bin/rm -rf /home/rhel/rpmbuild/BUILDROOT/pello-1.0.4-1.el9.x86_64
+ RPM_EC=0
++ jobs -p
+ exit 0
```

You can inspect these packages using the **rpm** and **rpmlint** commands.

Use the **rpm** command to list the contents of the source package.

```bash
rpm --query --list --package SRPMS/pello-1.0.4-1.el9.src.rpm
```
```nocopy
Pello-1.0.4.tar.gz
pello.spec
```

Use the **rpm** command to list the contents of the package.

```bash
rpm --query --list --package RPMS/noarch/pello-1.0.4-1.el9.noarch.rpm
```
```nocopy
/usr/bin/pello_greeting
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/PKG-INFO
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/SOURCES.txt
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/dependency_links.txt
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/entry_points.txt
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/not-zip-safe
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/requires.txt
/usr/lib/python3.9/site-packages/Pello-1.0.4-py3.9.egg-info/top_level.txt
/usr/lib/python3.9/site-packages/pello
/usr/lib/python3.9/site-packages/pello/__init__.py
/usr/lib/python3.9/site-packages/pello/__main__.py
/usr/lib/python3.9/site-packages/pello/__pycache__
/usr/lib/python3.9/site-packages/pello/__pycache__/__init__.cpython-39.opt-1.pyc
/usr/lib/python3.9/site-packages/pello/__pycache__/__init__.cpython-39.pyc
/usr/lib/python3.9/site-packages/pello/__pycache__/__main__.cpython-39.opt-1.pyc
/usr/lib/python3.9/site-packages/pello/__pycache__/__main__.cpython-39.pyc
/usr/lib/python3.9/site-packages/pello/__pycache__/pello_greeting.cpython-39.opt-1.pyc
/usr/lib/python3.9/site-packages/pello/__pycache__/pello_greeting.cpython-39.pyc
/usr/lib/python3.9/site-packages/pello/pello_greeting.py
/usr/share/doc/pello
/usr/share/doc/pello/README.md
/usr/share/licenses/pello
/usr/share/licenses/pello/LICENSE.txt
```

Use the **rpmlint** command to check for common problems in the package.
You will see a warning about **no-manual-page-for-binary**.
This warnings is expected in this case because **pello** did not include a man page.

```bash
rpmlint RPMS/noarch/pello-1.0.4-1.el9.noarch.rpm
```
```nocopy
pello.noarch: W: no-manual-page-for-binary pello_greeting
1 packages and 0 specfiles checked; 0 errors, 1 warnings.
```

Now that your package is built, you can install it on the system.

```bash
sudo dnf -y install RPMS/noarch/pello-1.0.4-1.el9.noarch.rpm
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 pello        noarch        1.0.4-1.el9           @commandline         16 k
### OUTPUT ABRIDGED ###
```

Finally, run the **pello_greeting** program.

```bash
pello_greeting
```
```nocopy
Hello World!
```

That concludes this challenge.
In the next challenge, you will build **pello** with **mock** instead of **rpmbuild**.