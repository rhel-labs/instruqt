---
slug: install
id: 6r6rmjxil4se
type: challenge
title: Install RHEL System Roles
teaser: In this challenge we'll install RHEL System Roles.
notes:
- type: text
  contents: Welcome to the lab
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

Ansible Automation Platform (AAP) has already been installed on the `aap` host. A basic configuration has already been performed.

Launch a new browser tab for the AAP web interface by clicking on the AAP Console button on the navigation bar.

![aap button](../assets/aapbutton.png)

Log into AAP with the following credentials.

>**Username**
>
>```yaml
>rhel
>```
>
>**Password**
>
>```yaml
>redhat
>```

PAH
>**Username**
>
>```yaml
>admin
>```
>
>**Password**
>
>```yaml
>ansible123!
>``


```bash
rhel-0ab2
```

Password

```bash
Redhat1!
```
