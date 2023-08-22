---
slug: using-your-jupyter-notebook
type: challenge
title: Using your Jupyter Notebook
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
  type: external
  port: 3000
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: Juypter Notebook
  type: service
  hostname: rhel
  port: 8888
  new_window: true
difficulty: basic
timelimit: 600
---
