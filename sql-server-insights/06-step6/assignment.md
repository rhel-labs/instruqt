---
slug: step6
id: whrb9qxabti2
type: challenge
title: Step 6
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: cloud.redhat.com
  type: website
  url: https://cloud.redhat.com
  new_window: true
difficulty: basic
timelimit: 900
---
# Verify issue resolved

Finally, reload the system page in your web browser.
Look to verify that the Insight related to ownership of SQL Server /var/opt/mssql is no longer displayed
for your machine.

You can also verify that SQL Server is now running on the machine

```bash
systemctl status mssql-server.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>
Active: active (running) since Tue 2020-03-10 15:22:53 EDT; 1min 56s ago
<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is __Active (running)__.
