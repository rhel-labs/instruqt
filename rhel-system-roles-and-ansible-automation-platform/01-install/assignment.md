---
slug: install
id: 6r6rmjxil4se
type: challenge
title: Install RHEL System Roles
teaser: In this challenge we'll install RHEL System Roles.
notes:
- type: text
  contents: We'll install RHEL System Roles on our control node `rhel`.
tabs:
- title: AAP
  type: terminal
  hostname: aap
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel3
  type: terminal
  hostname: rhel3
- title: RHEL Grafana Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
- title: AAP Console
  type: external
  url: https://aap.${_SANDBOX_ID}.instruqt.io
difficulty: basic
timelimit: 86400
---
In this lab there are 4 hosts. Below is a description of them and their purpose.

| Host | Description |
|------|-----------------------------------------------------|
| `aap` | Control node where Ansible Automation Platform is run. As well, Grafana will be installed here. |
| `rhel` | RHEL9 host where we will collect metrics from.      |
| `rhel2` | RHEL9 host where we will collect metrics from.      |
| `rhel3` | RHEL9 host where we will collect metrics from.      |
