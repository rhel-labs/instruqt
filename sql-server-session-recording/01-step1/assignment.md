---
slug: step1
id: bv3zfwyingyq
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to enable review recorded sessions in Red Hat Enterprise Linux, and track activity inside SQL Server using SQL Server's auditing feature.

    # Concepts included in this scenario:
    * Installing software for Terminal Session Recording
    * Enabling and recording terminal sessions
    * List recorded sessions
    * Replay recorded sessions using Web Console
    * Enabling SQL Server auditing
    * Viewing the audit events in the SQL Server audit log file

    # Example Usecase:
    Your compliance officer needs to have session recording across all OS and database
    activity for high privileged users. The session recording can be used to review all
    the actions carried out at the OS level, while SQL Server's auditing feature can be
    used to record database actions.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
# Installing software

>**Note:** For this scenario, we have started installing SQL Server on the machine. The installation task will take between 2-5 minutes to complete.

First, verify that SQL Server is running on the machine.

```bash
systemctl status mssql-server.service --no-pager
```

On the terminal, you should see something like below indicating that the mssql-server.service is running

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: active (running) since Monday 2019-07-15 19:24:18 EDT; 3h 59min left

<< OUTPUT ABRIDGED >>
</pre>

Next, install two rpm packages, __cockpit-session-recording__ and __tlog__ for the web console

```bash
yum -y install cockpit-session-recording tlog
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Installed:
  cockpit-session-recording-1-29.el8.noarch                      tlog-5-1.el8.x86_64

Complete!
</pre>

The first package, __cockpit-session-recording__ will add an additional feature
Web Console which you will be using to enable and configure session recording.
The __tlog__ package will provide the tools which will be used to both record
and view the recorded terminal sessions.
