---
slug: introduction
id: 3zaqqqir8n2f
type: challenge
title: Introduction to the lab
teaser: In this challenge we'll explore the lab environment.
notes:
- type: text
  contents: Welcome to the lab. We'll orient ourselves with this environment before
    going on to learn how to deploy RHEL system roles with Ansible Automation Platform.
tabs:
- id: pvxiw9nsfr4k
  title: AAP Web Console
  type: service
  hostname: aap
  port: 443
- id: pxfzxtyxcu0c
  title: AAP
  type: terminal
  hostname: aap
- id: bp0c5rbwoxfq
  title: rhel Grafana Web Console
  type: service
  hostname: rhel
  port: 3000
- id: zknrwzwt1wno
  title: rhel Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- id: kpipmfyrq2zx
  title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
- id: byxo0xpmrh3e
  title: rhel3 Web Console
  type: external
  url: https://rhel3.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
In this lab there are 4 hosts. Below is a description of them and their purpose.

| Host | Description |
|------|-----------------------------------------------------|
| `aap` | Control node where Ansible Automation Platform is run.|
| `rhel` | RHEL9 hosts that will be configured by RHEL system roles. As well, Grafana will be installed here.      |
| `rhel2` | RHEL9 hosts that will be configured by RHEL system roles.      |
| `rhel3` | RHEL9 hosts that will be configured by RHEL system roles.      |

![aap lab](../assets/aaplab.png)

Ansible Automation Platform (AAP) has already been installed on the `aap` host. A basic configuration has already been performed.

Launch a new browser tab for the AAP web interface by clicking on the AAP Console button on the navigation bar.

![aap button](../assets/aapbutton.png)

Log into AAP with the following credentials.

### Username

```yaml
rhel
```

### Password

```yaml
redhat
```

Enter the credentials at this login page.

![login](../assets/loginmenu.png)
