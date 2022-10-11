---
slug: installsystemroles
id: 3anmcihgppy3
type: challenge
title: Install System Roles
teaser: Install System Roles
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

Now we'll install system roles.

Make sure you are in the pane containing the `rhel` terminal session (type `ctrl-b + arrow key` to move between panes).
Enter the following command.

```bash
dnf install rhel-system-roles -y
```

![dnfinstall](../assets/dnfinstallsystemroles2.png)

The resulting output will look similar to the output below.

![srinstalled](../assets/srinstalled.png)
