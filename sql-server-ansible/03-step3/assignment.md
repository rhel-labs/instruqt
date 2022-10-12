---
slug: step3
id: vvfjkzgkuvp2
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Editor
  type: code
  hostname: rhel
  path: /root
difficulty: basic
timelimit: 1
---
## View and edit the Ansible Playbook

**Playbook**
A playbook is an entirely different way of running Ansible, that is far more powerful. In Ansible, a playbook is a yaml file consisting of multiple plays.

A play is a set of tasks mapped to a set of hosts.

**Editing variables in a playbook**

Click to edit ``site.yml`` in the inline editor.

This file has several variables, and one example variable that you might optionally want to change is the database sa password.
<pre class="file">
...
mssql_password: "p@55w0rD"
...
</pre>

