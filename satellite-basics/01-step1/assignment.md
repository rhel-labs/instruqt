---
slug: test
id: bg13dihc2imw
type: challenge
title: test
teaser: I just want to see if this works
notes:
- type: text
  contents: blah blah blah
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 86400
---

## Red Hat Satellite Basics

First, we'll log into the Red Hat Satellite Web User Interface (UI). Satellite has been preinstalled and installation is out of scope for this lab.

Click on 
