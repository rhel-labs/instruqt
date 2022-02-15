---
slug: step7
type: challenge
title: Step 7
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
# Reviewing a recorded session from the command-line

The command to use to review recorded sessions from the command-line is
`tlog-play`, which takes a session identifier to determine which session data
to replay.

In the default configuration, recorded session data is sent to the
__journald__ managed log.  As a result, to determine the available session
data, you will use the `journalctl`.  The following command will search
through the journal log and locate strings that contain the <pre>"rec"</pre>
string, plus the identifier included in that message.

```
journalctl -o verbose | grep -P "\"rec\".*?\,"
```

Below, is an example of one of those messages, but there will likely be more
than one message associated with each session.

![Journal Log Message](../assets/log-message.png)

To replay the session, you run `tlog-play` with the session identifier, using
the log message displayed above, the command would look like:
`tlog-play -r journal -M TLOG_REC=b9dd6a8391714e42be4f6f885875d48f-22ea-c2f05`

Your session identifier is going to be different, the following command will
use some shell tools to isolate the first recording from your journal.  As you
replay the session, your existing terminal session will be used for the replay.
once the replay is complete, your session will be returned to your control.  You
can interrupt the playback with a &lt;CTRL&gt;-C.

```
tlog-play -r journal -M TLOG_REC=$(journalctl -o verbose | grep -P "\"rec\".*?\." | cut -d, -f3 | cut -d: -f2 | head -n 1 | sed -e s/\"//g)
```

The above command will replay the session to completion, in real-time.

