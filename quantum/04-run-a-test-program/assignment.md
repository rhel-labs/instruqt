---
slug: run-a-test-program
id: lty78ecopfka
type: challenge
title: Run a Test Program
teaser: A short description of the challenge.
notes:
- type: text
  contents: Replace this text with your own text
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: Juypter Notebook
  type: service
  hostname: rhel
  port: 8888
  new_window: true
difficulty: basic
timelimit: 600
---
In this step, you will run a test program to demonstrate that your quantum simulation stack is functioning properly.