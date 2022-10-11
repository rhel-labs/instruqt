---
slug: step4
id: 4iysml0uyxdb
type: challenge
title: Step 4
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
## Recording a session

Create a shell as the __rhel__ user so that the session can be recorded.
Recall that the __rhel__ user's password is __redhat__.

```
ssh rhel@localhost
```

You will notice that when the `ssh` session starts, the __rhel__ user receives
the notice message configured in the __tlog__ configuration.

<pre class=file>
rhel@localhost's password: <b>redhat</b>

ATTENTION! Your session is being recorded!

[rhel@somehost ~]$
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
dnf list installed
```

Now that you have some data in a recorded session, you can log out of the
user's `ssh` session.
```
exit
```
