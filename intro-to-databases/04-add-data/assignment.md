---
slug: add-data
id: hhlyvuv7hp2w
type: challenge
title: Add Data
teaser: A short description of the challenge.
notes:
- type: text
  contents: Replace this text with your own text
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: website
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
  new_window: true
difficulty: basic
timelimit: 600
---
sample text