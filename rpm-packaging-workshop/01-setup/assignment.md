---
slug: setup
id: dnm3s2oqhoau
type: challenge
title: Setting up packaging workspace
tabs:
- id: yc66mfowgzwz
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
Welcome to the lab environment!
Here a few tips for completing these challenges.

* This sidebar can be resized by clicking and dragging on the three vertical dots.
This helps to avoid horizontally scrolling code blocks.
* Command blocks show you the commands you need to run to complete the challenge.
These will display a copy icon on the right side when you hover the mouse over them.
Clicking anywhere in this block will copy the command to your clipboard.
* Output blocks show the expected output from the commands you run.
These will **not** have a copy icon when you hover the mouse over them.
Do **not** attempt to run the text from these blocks as commands.
* The CTRL+v shortcut does not work to paste in the terminal interface.
You can however paste from the right click menu.

# Setting up the packaging workspace

Your first challenge is to set up your packaging workspace.
Expand the section headers below to work on each section of this challenge.

Installing the necessary packages
===

You will use a non-**root** user for most of the commands in these challenges.
However, each challenge starts as the **root** user.
For this challenge you will need to install some packages,
so do that before switching to a non-**root** user.

Install the **rpmdevtools** and **rpmlint** packages.

```
dnf -y install rpmdevtools rpmlint
```
```txt,nocopy
### OUTPUT ABRIDGED ###
Installing:
  rpmdevtools                       noarch        9.5-1.el9                  rhel-9-for-x86_64-appstream-rpms         93 k
  rpmlint                           noarch        1.11-19.el9                rhel-9-for-x86_64-appstream-rpms        202 k
 Installing dependencies:
  binutils                          x86_64        2.35.2-37.el9              rhel-9-for-x86_64-baseos-rpms           4.6 M
  binutils-gold                     x86_64        2.35.2-37.el9              rhel-9-for-x86_64-baseos-rpms           734 k
  desktop-file-utils                x86_64        0.26-6.el9                 rhel-9-for-x86_64-appstream-rpms         78 k
  dwz                               x86_64        0.14-3.el9                 rhel-9-for-x86_64-appstream-rpms        130 k
  ed                                x86_64        1.14.2-12.el9              rhel-9-for-x86_64-baseos-rpms            78 k
### OUTPUT ABRIDGED ###
```

Expand the next section header to continue the challenge.

Defining the %packager macro
===

Switch to the **rhel** user to complete the rest of the tasks.

```
sudo -iu rhel
```

As the **rhel** user, define the **%packager** macro in the **~/.rpmmacros** file.
This will be used later when you generate **changelog** entries.
You may use either your actual name and email or the example ones provided below.

The command below uses shell output redirection to write the contents of the **~/.rpmmacros** file.
If you like, you can write the same content to that file manually
with a command-line text editor such as vim or nano.

```
echo '%packager First Last <first@example.com>' >> ~/.rpmmacros
```

Use the **rpm** command to expand the macro to validate that it is defined correctly.

```
rpm --eval '%packager'
```
```txt,nocopy
First Last <first@example.com>
```

Expand the next section header to continue the challenge.

Create the rpmbuild directory tree
===

Finally, run the **rpmdev-setuptree** command to create the **rpmbuild** directory tree.

```
rpmdev-setuptree
```

In the **rhel** user's home directory is the directory structure for building packages.

```
tree rpmbuild
```
```txt,nocopy
rpmbuild
├── BUILD
├── RPMS
├── SOURCES
├── SPECS
└── SRPMS

5 directories, 0 files
```

You now have the requisite environment configuration to compile RPM packages.
over the next several steps, you will build your first package using this environment and the tools that you installed.