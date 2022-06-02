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
timelimit: 60
---

Now we'll install system roles.

Enter the following command.

```bash
dnf install rhel-system-roles ansible-core -y
```

![dnfinstall](../assets/dnfinstallsystemroles.png)

The resulting output will look similar to the output below.

![srinstalled](../assets/srinstalled.png)
