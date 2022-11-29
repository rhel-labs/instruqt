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
- title: RHEL Grafana Console
  type: external
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3000
difficulty: basic
timelimit: 3000
---
In this lab there are 4 hosts. Below is a description of them and their purpose.

| Host | Description |
|------|-----------------------------------------------------|
| `rhel` | Control node where the metrics system role will run. As well, Grafana will be installed here. |
| `rhel2` | RHEL9 host where we will collect metrics from.      |
| `rhel3` | RHEL9 host where we will collect metrics from.      |
| `rhel4` | RHEL9 host where we will collect metrics from.      |

Initially we will configure the first 3 hosts. After, we will add `rhel4` to the observability system since it is likely you will need to add additional hosts to your infrastructure well after the initial installation and configuration has taken place.

We'll start by installing RHEL System Roles on `rhel`

First, click on the menu tab labelled `rhel`.

![rhel tab](../assets/rhel_tab.png)

Copy and paste the following command into the `rhel` terminal.

```bash
dnf install -y rhel-system-roles
```

The resulting output should look similar to below.

![output](../assets/dnf_output.png)

RHEL System Roles are now installed.
