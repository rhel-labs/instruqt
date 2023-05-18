---
slug: sudoers
id: b50xqiiorqoz
type: challenge
title: Sudo is hard
notes:
- type: text
  contents: |
    The next thing **Scott** tells you is that he tried to setup some sudo rights for the web guys.  "They just want to be able to restart httpd!  WHY IS THIS SO HARD?!" he says.

    Can you create a sudoers drop-in that let's the "webteam" user restart (and otherwise manage) httpd via systemd?
tabs:
- title: RHEL
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Deleted file won't delete

**Scott**: I just cant get the webteam user to run systemctl commands on httpd through sudo!

Can you configure sudo to allow the `webteam` user to run `systemctl` commands on the `httpd` service through sudo **without** requiring a password? (This should include things like, start, stop, restart, status, and reload)