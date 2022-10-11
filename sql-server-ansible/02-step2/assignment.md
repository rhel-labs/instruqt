---
slug: step2
id: 0xaiohi6fsov
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Download the Ansible Role

Ansible uses the concept of **roles** to better allow modular code and avoid repeating yourself. A role is simply a folder structure that Ansible knows where to load vars files, tasks and handlers from.

Ansible makes it easily share roles with the community or download roles that have been created by other members of the community using [Ansible Galaxy](https://galaxy.ansible.com/).

To access Ansible Galaxy, ansible ships with a command line tool called **ansible-galaxy** that can be used to install roles in a specific role directory

```
ansible-galaxy collection install microsoft.sql --force
```

> **NOTE:** The role from ansible-galaxy is not yet supported, and we plan to add support for this in a future version of RHEL.
