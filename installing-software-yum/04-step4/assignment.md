---
slug: step4
id: efl9q8tbr9jl
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 600
---
# Using RPM to run detailed queries

YUM is the standard package manager, but this does not mean that RPM is
obsolete. Detailed queries can be carried out using RPM using the
query option (`-q`). This step will walk you through three examples of how to use
this option.

# Listing files installed by a package

You can combine the `-q` option with the list option (`-l`) to display all of the
files that are installed by a specific package. This information is hidden by
default to keep the package installation process simple, but it is often useful
to know where specific files are located.

```
rpm -ql wireshark
```

<pre class=file>
/usr/bin/wireshark
/usr/lib/.build-id
/usr/lib/.build-id/9b
/usr/lib/.build-id/9b/f3ec88dd7a948dfaf1382498091fa57333c153
<< OUTPUT ABRIDGED >>
</pre>

Now you can see that the Wireshark application is located at `usr/bin/wireshark`.

# Listing installation scripts

Some packages run scripts to finish up their installation process. The `--scripts`
option can be used in combination with `rpm -q` to return the contents of these
postinstall scripts for a specific package. Wireshark does not actually have
any postinstall scripts, so instead try this command with the __httpd__ package.

```
rpm -q --scripts httpd
```

<pre class=file>
postinstall scriptlet (using /bin/sh):

if [ $1 -eq 1 ] ; then
        # Initial installation
        systemctl --no-reload preset httpd.service htcacheclean.service httpd.socket &>/dev/null || :
fi
<< OUTPUT ABRIDGED >>
</pre>

The output shows a script that creates a preset for the __httpd__ service behind
the scenes when the package is installed.

# Showing changelog

Specifying `--changelog` with `rpm -q` will display what has recently been
changed in a package.

```
rpm -q --changelog wireshark
```

<pre class = file>
Tue Oct 29 2019 Michal Ruprich <mruprich@redhat.com> - 1:2.6.2-12
- Resolves: #1609737 - wiretap does not write "drop_count" in pcapng format

* Mon Apr 29 2019 Michal Ruprich <mruprich@redhat.com> - 1:2.6.2-11
- Related: #1602731 - Fixing multilib problem in devel subpackage
<< OUTPUT ABRIDGED >>
</pre>

The next step will walk you through another use for `rpm`, file validation.
