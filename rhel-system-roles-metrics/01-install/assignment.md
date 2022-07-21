---
slug: install
id: ufdneafyxydc
type: challenge
title: Install RHEL System Roles
teaser: In this challenge we'll install RHEL System Roles.
notes:
- type: text
  contents: We'll install RHEL System Roles on our control node `rhel`.
tabs:
- title: rhel
  type: terminal
  hostname: rhel
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel3
  type: terminal
  hostname: rhel3
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: RHELs Web Console
  type: external
  url: https://rhels.${_SANDBOX_ID}.instruqt.io:9090
- title: RHEL3 Web Console
  type: external
  url: https://rhel3.${_SANDBOX_ID}.instruqt.io:9090
- title: RHEL Grafana Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
difficulty: basic
timelimit: 86400
---
First, click on the menu tab labelled `rhel`.

![rhel tab](../assets/rhel_tab.png)

Copy and paste the following command into the `rhel` terminal.

```bash
dnf install -y rhel-system-roles
```

The resulting output should look similar to below.

![output](../assets/dnf_output.png)

RHEL System Roles are now installed.
