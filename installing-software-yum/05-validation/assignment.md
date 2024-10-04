---
slug: validation
id: batycjhys7gr
type: challenge
title: Validating package files using `rpm`
tabs:
- id: g7ahdyescyrf
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

If a program is suddenly misbehaving, it could be related to some key files not being installed properly. `rpm` has a validation option (`-V`) which will compare the local files with the expected files for the package. Remove a file from the Wireshark package to test out this validation functionality:

```bash
rm -f /usr/share/icons/hicolor/256x256/apps/wireshark.png
```

Use the `-V` option with `rpm` to check the file status of Wireshark.

```bash
rpm -V wireshark
```

<pre class=file>
missing     /usr/share/icons/hicolor/256x256/apps/wireshark.png
</pre>

Now that you have seen there is a missing file, reinstall the Wireshark
package to return it to its proper state:

```bash
dnf -y reinstall wireshark
```

<pre class=file>
<< OUTPUT ABRIDGED >>
Arch   Version        Repository                        Size
===================================================================
Reinstalling:
wireshark
x86_64 1:2.6.2-12.el8 rhel-9-for-x86_64-appstream-rpms 3.7 M
<< OUTPUT ABRIDGED >>
</pre>

Check that __wireshark.png__ has been restored:

```bash
ls /usr/share/icons/hicolor/256x256/apps/
```

<pre class=file>
wireshark.png
</pre>

The command `rpm -V` is useful for more than just finding missing files.
This command can inform the user if any files have changed since installation.
To test this out, run the validation command on the PAM package.

```bash
rpm -V pam
```

<pre class=file>
S.5....T.  c /etc/pam.d/password-auth
S.5....T.  c /etc/pam.d/system-auth
</pre>

This query returns two files with unexpected criteria, __password-auth__ and __system-auth__. The first column of this output tells you that both of these files have an unexpected size, checksum, and timestamp. Both of these files are configuration files, so it makes sense that they would be modified after installation to suit the purpose of this particular system.
