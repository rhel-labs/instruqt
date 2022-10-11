---
slug: step1
id: gagnq6d1penw
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Overview:
    Package managers are centralized methods of accessing software repositories. Using package managers for installing and updating software removes many opportunities for user error and automates numerous installation steps. On RHEL, YUM is the default package manager, but you will also see RPM.

    # Goal:
    After completing this lab, users will feel comfortable adding, removing, and updating packages.

    # Concepts included in this scenario:
    * Install a package with `yum`
    * Update and remove packages with `yum`
    * Roll back a transaction with `yum history`
    * Use `rpm` for detailed queries
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3420
---
# What is a package manager?

Package managers are programs which install, update, and remove software.
Doing these operations by hand would be tedious and prone to mistakes. Bundling these
functionalities into a single tool gives users a more streamlined experience.

YUM has even more utility because it performs dependency resolution whenever
it installs, removes, or updates software. The upcoming steps will give
examples of how to use YUM to streamline your package management.

# Installing a package with `yum`

Install the network analysis application Wireshark using `yum`. This application
is useful for troubleshooting network packets that are traveling in and out
of your system. This functionality in particular is not important to this lab,
this application was picked simply because it serves as a good test subject for
the upcoming examples.


```
yum -y install wireshark
```

>_Note:_ The `-y` option will automatically answer yes to any prompts during the installation. Using this option is not best practice when installing software on your own system, but it is useful for streamlining some operations in this lab.

This installation generates a large output, so here is a high level
summary of what each section means. The first section shows all of the packages
that must be installed as dependencies for Wireshark:

<pre class=file>
<< OUTPUT ABRIDGED >>
Arch   Version         Repository                        Size
===================================================================
Installing:
wireshark
x86_64 1:2.6.2-12.el8  rhel-8-for-x86_64-appstream-rpms 3.7 M
Installing dependencies:
flac-libs
<< OUTPUT ABRIDGED >>
</pre>

The next section of the output shows a verification status for each dependent package. In this case,
YUM made sure that 36 other packages were up to date.

<pre class=file>
<< OUTPUT ABRIDGED >>
Verifying        : libgudev-232-4.el8.x86_64               35/36
Verifying        : pcre2-utf16-10.32-2.el8.x86_64          36/36
Installed products updated.
<< OUTPUT ABRIDGED >>
</pre>

The final section of the output is a list of all of the packages that were
installed in support of Wireshark's installation.

<pre class=file>
<< OUTPUT ABRIDGED >>
Installed:
  flac-libs-1.3.2-9.el8.x86_64
  glx-utils-8.4.0-5.20181118git1830dcb.el8.x86_64
  gsm-1.0.17-5.el8.x86_64
<< OUTPUT ABRIDGED >>

Complete!
</pre>

You can verify this installation with the `yum list` command:

```
yum list wireshark
```

<pre class=file>
<< OUTPUT ABRIDGED >>
Installed Packages
wireshark.x86_64
         1:2.6.2-12.el8 @rhel-8-for-x86_64-appstream-rpms
</pre>

This shows how powerful YUM is, as a single command will take care of the installation
seamlessly. Next you will see how to update and remove packages with `yum`.
