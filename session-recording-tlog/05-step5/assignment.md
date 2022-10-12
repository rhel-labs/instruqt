---
slug: step5
id: i8mwfd7dhxuv
type: challenge
title: Step 5
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
# Recording a session

Change user to the __rhel__ user so that the session can be recorded.

```
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

```
ls /tmp
```

```
who
```

```
df -hP
```

```
yum list installed
```

Now that you have some data in a recorded session, you can log out of the user's terminal session.
```
exit
```

