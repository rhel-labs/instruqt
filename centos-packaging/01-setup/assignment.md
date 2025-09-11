---
slug: setup
id: awceswqtdpln
type: challenge
title: Workspace setup
teaser: In this challenge, you will set up your packaging workspace.
tabs:
- id: or83eeu9fljl
  title: Terminal
  type: terminal
  hostname: centos
  cmd: sudo -iu centos
difficulty: ""
enhanced_loading: null
---
Welcome to the lab environment!
Here a few tips for completing these challenges.

* This sidebar can be resized by clicking and dragging on the three vertical dots.
This helps to avoid horizontally scrolling code blocks.
* **Command blocks** show you the commands you need to run to complete the challenge.
These blocks will have a copy button in the top right corner.
* **Output blocks** show the expected output from the commands you run.
They look similar to command blocks,
except they will **not** have a copy button in the top right corner.
Do **not** attempt to run the text from these blocks as commands.
* The CTRL+v shortcut does not work to paste in the terminal interface.
You can however paste from the right click menu.

# Setting up the packaging workspace

Your first challenge is to set up your packaging workspace.
Expand the section headers below to work on each section of this challenge.

Installing the necessary packages
===

Install the **rpmdevtools** and **rpmlint** packages.

```bash
sudo dnf -y install rpmdevtools rpmlint
```
```nocopy
### OUTPUT ABRIDGED ###
Installing:
 rpmdevtools                   noarch   9.5-1.el9              appstream    89 k
 rpmlint                       noarch   1.11-19.el9            appstream   198 k
Installing dependencies:
 adobe-source-code-pro-fonts   noarch   2.030.1.050-12.el9.1   baseos      832 k
 binutils                      x86_64   2.35.2-43.el9          baseos      4.6 M
 binutils-gold                 x86_64   2.35.2-43.el9          baseos      735 k
 bzip2                         x86_64   1.0.8-8.el9            baseos       56 k
 cpio                          x86_64   2.13-16.el9            baseos      275 k
### OUTPUT ABRIDGED ###
```

Expand the next section header to continue the challenge.

Defining the %packager macro
===

Define the **%packager** macro in the **~/.rpmmacros** file.
This will be used later when you generate **changelog** entries.
You may use either your actual name and email or the example ones provided below.

The command below uses shell output redirection to write the contents of the **~/.rpmmacros** file.
If you like, you can write the same content to that file manually
with a command-line text editor such as vim or nano.

```bash
echo '%packager First Last <first@example.com>' >> ~/.rpmmacros
```

Use the **rpm** command to expand the macro to validate that it is defined correctly.

```bash
rpm --eval '%packager'
```
```nocopy
First Last <first@example.com>
```

Expand the next section header to continue the challenge.

Create the rpmbuild directory tree
===

Finally, run the **rpmdev-setuptree** command to create the default directories for building packages.

```bash
rpmdev-setuptree
```

You can observe the directories that were created using the **tree** command.

```bash
tree rpmbuild
```
```nocopy
rpmbuild
├── BUILD
├── RPMS
├── SOURCES
├── SPECS
└── SRPMS

5 directories, 0 files
```

That concludes this challenge.
In the next challenge, you will build your first package using this environment and the tools that you installed.