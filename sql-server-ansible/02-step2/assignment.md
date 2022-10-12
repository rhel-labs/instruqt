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
timelimit: 900
---
# Install the Ansible Role

Ansible uses the concept of **roles** to better allow modular code and avoid repeating yourself. A role is simply a folder structure that Ansible knows where to load vars files, tasks and handlers from.

Red Hat Enterprise Linux provides some of these roles in the form of Collections.  Microsoft SQLServer is one of these. You can install this collection via your package manager.

We are also installing `rhel-system-roles` so we can take advantage of the firewalll system role later.

```
dnf install -y ansible-collection-microsoft-sql rhel-system-roles
```

