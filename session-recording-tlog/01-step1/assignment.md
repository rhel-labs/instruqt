---
slug: step1
id: zzxlhhp2kg6b
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to enable Terminal
    Session Recording and review recorded sessions.

    # Concepts included in this scenario:
    * Installing software for Terminal Session Recording
    * Enabling and recording terminal sessions
    * List recorded sessions
    * Replay recorded sessions using Web Console
    * Replay recorded sessions using the __tlog__ command

    # Example Usecase:
    An administrator on your team is having difficulty performing a task on a
    machine.  You would like to review what has been done to see the state of
    the machine and task.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 300
---
# Installing software

Install two rpm packages, __cockpit-session-recording__ and __tlog__.

```
yum install -y cockpit-session-recording tlog
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Installed:
  cockpit-session-recording-4-2.el8.noarch
  tlog-8-2.el8.x86_64

Complete!
</pre>

The first package, __cockpit-session-recording__ will add an additional feature
Web Console which you will be using to enable and configure session recording.
The __tlog__ package will provide the tools which will be used to both record
and view the recorded terminal sessions.
