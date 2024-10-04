---
slug: review-cli
id: gm9z6fjvygoa
type: challenge
title: Reviewing a recorded session from the command-line
tabs:
- id: ikprcm1tykvd
  title: Terminal
  type: terminal
  hostname: rhel
- id: 6lyvssppivjh
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

The command to use to review recorded sessions from the command-line is `tlog-play`, which takes a session identifier to determine which session data to replay.

In the default configuration, recorded session data is sent to the __journald__ managed log.  As a result, to determine the available session data, you will use the command `journalctl`.  The following command will search through the journal log and locate strings that contain the `rec` string, plus the identifier included in that message.

```bash,run
journalctl -o verbose | grep -P "\"rec\".*?\,"
```

Below, is an example of one of those messages, but there will likely be more than one message associated with each session.

<a href="#1">
 <img alt="An example image" src="../assets/log-message.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/log-message.png" />
</a>

To replay the session, you run `tlog-play` with the session identifier, using the log message displayed above, the command would look like:

`tlog-play -r journal -M TLOG_REC=b9dd6a8391714e42be4f6f885875d48f-22ea-c2f05`

Your session identifier is going to be different, the following command will use some shell tools to isolate the first recording from your journal.  As you replay the session, your existing terminal session will be used for the replay. Once the replay is complete, your session will be returned to your control.  You can interrupt the playback with a `<CTRL>-C`.

```bash,run
tlog-play -r journal -M TLOG_REC=$(journalctl -o verbose | grep -P "\"rec\".*?\." | cut -d, -f3 | cut -d: -f2 | head -n 1 | sed -e s/\"//g)
```

The above command will replay the session to completion, in real-time.

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
