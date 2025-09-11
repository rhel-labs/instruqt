---
slug: bello-spec
id: tnijn1sjscqj
type: challenge
title: Packaging bello - Writing the SPEC file
teaser: In this step, you will be writing the SPEC file which describes how to build
  the RPM package from the source code you positioned in the previous step.
tabs:
- id: y4vmxzfxnxcz
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
Now you are going to create the spec file in the **SPECS** directory.
You will start with the **preamble**, where metadata about the package is defined.
The table below describes the **preamble** tags we are going to use for the **bello** package.

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
These properties together form a useful identifier known as the **NVR** (e.g. **bash-5.1.8-5.el9**).
For now, set the version to **0**, even though this does not match the version of the software.
You will set this to the correct version in a future step.

The command below uses what is called a "here document" to write the contents of the spec file.
If you like, you can write the same content to that file manually
with a command-line text editor such as vim or nano.


```
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

```
cat >> SPECS/bello.spec << EOF
Summary:        Hello World example implemented in bash script
License:        GPLv3+
URL:            https://github.com/redhat-developer/rpm-packaging-guide
Source:         %{url}/raw/master/example-code/bello-%{version}.tar.gz
BuildArch:      noarch
EOF
```

This completes the preamble section for the **bello** application.

The next part of the spec file is **%description**.
While the **Summary** is limited to one line,
the **%description** can be used to write a longer description of the package
that may span multiple lines if needed.

Add a sentence describing the software included in the package.

```
cat >> SPECS/bello.spec << EOF

%description
The long description for our Hello World Example implemented in bash script.
EOF
```

The next part of the spec file is **%prep**.
This is used to perform any steps needed to prepare the source code for building the software.

Add the **%autosetup** macro,
which will extract the source code archive.

```
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

```
cat >> SPECS/bello.spec << EOF

%build
EOF
```

The next part of the spec file is **%install**.
This is used to perform any steps needed to place files and directories into the appropriate locations,
relative to the **%{buildroot}**.

The command below will place the **bello** script into the **%{buildroot}**,
with the appropriate permissions and creating parent directories as needed.
The **%{\_bindir}** macro expands to **/usr/bin**,
which is where the script will be on a system that installs this package.

```
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

```
cat >> SPECS/bello.spec << EOF

%files
%license LICENSE
%{_bindir}/bello
EOF
```

The last part of the spec file is **%changelog**.
It lists the changes that have happened to the package between different versions and releases.

Leave this empty for now.

```
cat >> SPECS/bello.spec << EOF

%changelog
EOF
```

Use the **rpmdev-bumpspec** tool to create a changelog entry.
This tool will also change the **Version** field in the preamble to the correct value.

```
rpmdev-bumpspec --new 0.1 --comment 'Initial package' SPECS/bello.spec
```

Review the spec file you have written.

```
cat SPECS/bello.spec
```
```txt,nocopy
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
* Tue May 23 2023 First Last <first@example.com> - 0.1-1
- Initial package

```

In the next step, you will build and validate the RPM package.