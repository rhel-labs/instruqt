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
- id: fawzh4mfupxy
  title: controlnode
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing"
- id: xjo3jxzqs5od
  title: rhelvm
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing-rhelvm"
- id: dl1pzm38ev9g
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

Now we'll install system roles.

Switch to the [button label="controlnode"](tab-0) terminal by clicking on this button: [button label="controlnode"](tab-0)

![rhel tab](../assets/rhel-tab.png)

Enter the following command.

```bash,run
dnf install rhel-system-roles -y
```

The resulting output will look similar to the output below.

![srinstalled](../assets/srinstalled.png)
