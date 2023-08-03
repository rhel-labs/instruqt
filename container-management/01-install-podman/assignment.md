---
slug: install-podman
type: challenge
title: Install Podman
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
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: Grafana (Podman)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 600
---
