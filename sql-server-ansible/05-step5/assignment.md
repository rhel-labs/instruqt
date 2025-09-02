---
slug: step5
id: bpy9txtjpg4h
type: challenge
title: Step 5
tabs:
- id: gfnx2akiqqsb
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
enhanced_loading: null
---
## Verify that Microsoft SQL Server is installed on the machine

To verify that SQL Server is running on the machine, lets use the systemctl status command

```bash
systemctl status mssql-server.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: active (running) since Monday 2019-07-15 19:24:18 EDT; 3h 59min left

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is __active (running)__.

