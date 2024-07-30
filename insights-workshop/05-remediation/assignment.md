---
slug: remediation
id: 3e7gkedyjhxw
type: challenge
title: Remediating the reported Insight
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

We'll apply the recommendation to disallow `root` logins via SSH. Run the following command.

```bash,run
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
```

To view the results, enter the following command.

```bash,run
cat /etc/ssh/sshd_config | grep PermitRootLogin
```

![Fixed SSH](../assets/sshrootlogininsightsremedy.png)

Force a Red Hat Insights checkin so that a new batch of system data is uploaded to Insights.

```bash,run
insights-client
```

<pre class=file>
Starting to collect Insights data for rhel-2e23a
Uploading Insights data.
Successfully uploaded report from rhel-2e23a to account 6227255.
View details about this system on cloud.redhat.com:
https://cloud.redhat.com/insights/inventory/1e06ad31-8eeb-4f29-8119-5689f72f8533
</pre>
