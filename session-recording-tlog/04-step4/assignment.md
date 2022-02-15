---
slug: step4
id: zpweqokemyme
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
timelimit: 300
---
# Reviewing the configuration

Switch back to the Terminal in your lab environment.

As mentioned on the previous step, the Web Console actions have written a
small configuration file for sssd,
__/etc/sssd/conf.d/sssd-session-recording.conf__  You can review it to verify
that the scope has been set to __all__ so that
all sessions for all users and groups will be recorded.

```
cat /etc/sssd/conf.d/sssd-session-recording.conf
```

<pre class=file>
[session_recording]
scope=all
users=
groups=
</pre>

Changes to the other configuration options displayed by Web Console would have
stored those changes in __/etc/tlog/tlog-rec-session.conf__.  For example, the
__notice__ message displayed to users who are having their session recorded.
You can inspect this file as well, if desired.

```
cat /etc/tlog/tlog-rec-session.conf
```

<pre class=file>
<<OUTPUT ABRIDGED>>

"notice" : "ATTENTION! Your session is being recorded!",
</pre>
