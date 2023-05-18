---
slug: sudoers
id: b50xqiiorqoz
type: challenge
title: Sudo is hard
notes:
- type: text
  contents: |-
    You've walked in to the office, and barely feel the warmth of your first mug of coffee when your boss, **Scott**, calmly walks up to you.

    "Yeah, so look, theres a problem.  You were out yesterday, and... you know, I _couldn't_ bother you because of that pesky company policy thing...  Anyway, you know before being a manager, I did the same work as you, so I handled a few things for you.  You're welcome!"

    ## Sudo is hard

    **Scott** goes on to tell you that he setup some sudo rights for the web guys.  "They just want to be able to manage httpd.  Must be on some kinda power trip over there in the web group." he says.

    Can you fix his sudoers drop-in so that it let's the "webteam" user restart (and otherwise manage) httpd via systemd?  **Scott** got started on one in `/etc/sudoers.d/webteam-sudo` but..well.. Contrary to his belief, it's not working.
tabs:
- title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Deleted file won't delete

**Scott**: "I put one of those drop-in things in.  Should be good to go! But they say its not working, must be a pebkac right?"

Scott's drop-in is in ```/etc/sudoers.d/webteam-sudo```

Can you configure sudo to allow the `webteam` user to run `systemctl` commands on the `httpd` service through sudo **without** requiring a password? (This should include things like, start, stop, restart, status, and reload)