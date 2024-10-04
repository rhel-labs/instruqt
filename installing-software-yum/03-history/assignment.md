---
slug: history
id: agw3147hja2r
type: challenge
title: Using `dnf history` to roll back a transaction
tabs:
- id: cpdd9bkmoxym
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

The `history` subcommand provides a summary of recent `dnf` transactions.

```bash
dnf history
```

The output contains transaction IDs in the first column, which are how you reference
specific locations in the transaction history when executing rollbacks.

<pre class=file>
ID| Command                  | Date and time    | Action(s)| Altered
------------------------------------------------------------------
12 | -y remove httpd         | 2021-12-22 01:12 | Removed  |   10
11 | -y update bash          | 2021-12-22 01:12 | Upgrade  |    1
10 | -y install wireshark    | 2021-12-22 01:07 | Install  |   98
 9 | install -y httpd        | 2021-12-22 01:04 | Install  |   10  <
 8 |                         | 2021-12-22 01:02 | I, U     |   81 >
 7 | install -y git          | 2021-09-03 15:10 | Install  |   48
</pre>

This subcommand is also useful for rolling back transactions if you erroneously
install or update a package, as it cleans up all of the dependencies associated
with the package. Rollback the state of your system to before you uninstalled
__httpd__:

```bash
dnf -y history rollback 11
```

>_NOTE:_ The number 11 here is used here to specify that the rollback the state of the system to how it was at transaction ID 6, or before you removed __httpd__.

You can use other relative offsets, such as `last-3`, or you can use absolute transaction IDs. For example, `dnf history rollback 2` would rollback to the transaction where __rsync__ was installed.

<pre class=file>
<< OUTPUT ABRIDGED >>
Installed:
  apr-1.6.3-11.el8.x86_64
  apr-util-1.6.1-6.el8.x86_64
  apr-util-bdb-1.6.1-6.el8.x86_64
  apr-util-openssl-1.6.1-6.el8.x86_64
  httpd-2.4.37-39.module+el8.4.0+9658+b87b2deb.x86_64
  httpd-filesystem-2.4.37-39.module+el8.4.0+9658+b87b2deb.noarch

Complete!
</pre>

This command reinstalled the RPMs that are part of __httpd__ (including
all dependencies),
restoring the system state to how it was before the previous transaction.

There are many more subcommands that you can use to customize how DNF behaves.
Check out this [YUM Command Cheat Sheet for RHEL](https://access.redhat.com/sites/default/files/attachments/rh_yum_cheatsheet_1214_jcs_print-1.pdf) for more info.
>_NOTE:_ DNF and YUM are syntactically identical. You can refer to the YUM cheat sheet for subcommands that will all work with DNF.
