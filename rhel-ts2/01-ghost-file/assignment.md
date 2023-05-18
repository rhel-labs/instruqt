---
slug: ghost-file
id: pvz8r8kt39hr
type: challenge
title: Deleted File
notes:
- type: text
  contents: |
    You've walked in to the office, and barely feel the warmth of your first mug of coffee when your boss, **Scott**, calmly walks up to you.

    "Yeah, so look, theres a problem.  You were out yesterday, and... you know, I _couldn't_ bother you because of that pesky company policy thing...  Anyway, you know before being a manager, I did the same work as you, so I handled a few things for you.  You're welcome!"

    # Full Filesystem

    The first thing **Scott** tells you is that /var/log had filled up on one of the core servers.  He found out that there was a huge log file there, /var/log/biglog, imagine that.

    He looked at the log, but couldnt figure out why it was so huge.  So, he deleted it, but the disk space didnt clear up!

    "So yea, the disk space monitoring alert was getting really annoying, so I just ack'd it and figured you could deal with it when you got back.  You're welcome!"

    Can you figure out why the disk is still full?
tabs:
- title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Deleted file won't delete

**Scott**: This RHEL thing is hard.. Why didn't deleting the file actually clear up the space?! I wish I had a GUI on this server.

The file _was_ ```/var/log/biglog```

Can you find out why the space is still consumed?
