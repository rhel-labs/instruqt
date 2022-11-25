---
slug: installsystemroles
id: 3anmcihgppy3
type: challenge
title: Install System Roles
teaser: Install System Roles
notes:
- type: text
  contents: Install the firewall RHEL system role.
tabs:
- title: rhel
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "firewall-testing"
- title: rhelvm
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "firewall-testing-rhelvm"
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

Now we'll install system roles.

Click the `rhel` terminal session tab.

![rhel tab](../assets/rhel-tab.png)

Enter the following command.

```bash
dnf install rhel-system-roles -y
```

The resulting output will look similar to the output below.

![srinstalled](../assets/srinstalled.png)
