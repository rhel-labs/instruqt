---
slug: recording
id: i8mwfd7dhxuv
type: challenge
title: Recording a session
tabs:
- id: 8dc7nlcc2qwj
  title: Terminal
  type: terminal
  hostname: rhel
- id: i4gur9bfc6ai
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

Change user to the __rhel__ user so that the session can be recorded.

```bash,run
su - rhel
```

You will notice that when the `bash` session starts, the __rhel__ user receives
the notice message configured in the __tlog__ configuration.

<pre class=file>
root@rhel:~# su - rhel
Last login: Thu Feb  3 19:21:21 UTC 2022 from ::ffff:136.32.60.35 on web console
Locale charset is ANSI_X3.4-1968 (ASCII)
Assuming locale environment is lost and charset is UTF-8

ATTENTION! Your session is being recorded!

[rhel@rhel ~]$
</pre>

Run some commands in the __rhel__ user's session.

```bash,run
ls /tmp
```

```bash,run
who
```

```bash,run
df -hP
```

```bash,run
dnf list installed
```

Now that you have some data in a recorded session, you can log out of the user's terminal session.

```bash,run
exit
```
