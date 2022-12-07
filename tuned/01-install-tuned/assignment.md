---
slug: install-tuned
id: qvxupc8t14hz
type: challenge
title: Install and enable TuneD
teaser: Install and enable TuneD.
notes:
- type: text
  contents: You have been tasked as a systems administrator to deploy a new RHEL 8
    server and tune it for running Microsoft SQL Server.  This is lab you will get
    some hands-on experience setting up TuneD to assist you with the tuning portion
    of this task and you will create a custom TuneD profile to optimize it for your
    use case
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3420
---

As a system administrator, you can use the TuneD application to optimize the performance profile of your system for a variety of use cases.

The first step is we need to ensure that TuneD is installed and enabled

Let's make sure we have the `tuned` package available to install and also check for additional profiles we may be interested in. Copy and paste the command below into __> Shell__.

```bash
dnf search tuned
```

Here's what the result should look similar to.

<pre>

<<< OUTPUT ABRIDGED >>>
================================================================================== Name Exactly Matched: tuned
tuned.noarch : A dynamic adaptive system tuning daemon
================================================================================= Name & Summary Matched: tuned
tuned-gtk.noarch : GTK GUI for tuned
tuned-profiles-atomic.noarch : Additional tuned profile(s) targeted to Atomic
tuned-profiles-compat.noarch : Additional tuned profiles mainly for backward compatibility with tuned 1.0
tuned-profiles-cpu-partitioning.noarch : Additional tuned profile(s) optimized for CPU partitioning
tuned-profiles-mssql.noarch : Additional tuned profile(s) for MS SQL Server
tuned-profiles-oracle.noarch : Additional tuned profile(s) targeted to Oracle loads
tuned-utils.noarch : Various tuned utilities

<<< OUTPUT ABRIDGED >>>

</pre>

We see `tuned` available and there is also a `tuned-profiles-mssql` package that looks to be in-line with what we are looking for.

Let's go ahead and install both

Copy and paste the command below into __> Shell__.

```bash
dnf install tuned tuned-profiles-mssql -y
```
