---
slug: step3
id: vvfjkzgkuvp2
type: challenge
title: Step 3
tabs:
- id: wrjwleo11xqg
  title: Terminal
  type: terminal
  hostname: rhel
- id: 0i2ixltevadb
  title: Editor
  type: code
  hostname: rhel
  path: /root
difficulty: basic
timelimit: 900
enhanced_loading: null
---
## View and edit the Ansible Playbook

**Playbook**
A playbook is an entirely different way of running Ansible, that is far more powerful. In Ansible, a playbook is a yaml file consisting of multiple plays.

A play is a set of tasks mapped to a set of hosts.

**Editing variables in a playbook**

You should notice a new tab in which you can edit ``site.yml`` in the inline editor.

This file has several variables, and one example variable that you might optionally want to change is the database sa password.
<pre class="file">
...
mssql_password: "p@55w0rD"
...
</pre>

You'll also notice that ``site.yml`` includes the firewall RHEL system role, which opens the mssql port.  You can learn more about the firewall RHEL system role in the <a target="new" href="https://lab.redhat.com/tracks/firewall-system-role">Red Hat Enterprise Linux Firewall System Role lab</a>.