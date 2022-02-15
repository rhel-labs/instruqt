---
slug: step5
id: 3e7gkedyjhxw
type: challenge
title: Step 5
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: service
  hostname: rhel
  path: /
  port: 9090
difficulty: basic
timelimit: 900
---
# Remediating the reported Insight

You will follow the recommendation and apply the required change to secure updates from the updated package to the `rhel-8-for-x86_64-baseos-rpms` software repository.

```
sed -i '/\[rhel-8-for-x86_64-baseos-rpms\]/,/^ *\[/ s/gpgcheck = 0/gpgcheck = 1/' /etc/yum.repos.d/redhat.repo
```

To view the results, enter the following command.

```
grep -A 4 rhel-8-for-x86_64-baseos-rpms /etc/yum.repos.d/redhat.repo
```

<pre class=file>
[rhel-8-for-x86_64-baseos-rpms]
name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)
baseurl = https://cdn.redhat.com/content/dist/rhel8/$releasever/x86_64/baseos/os
enabled = 1
gpgcheck = 1
</pre>

Force a Red Hat Insights checkin so that a new batch of system data
is uploaded to Insights.

```
insights-client
```

<pre class=file>
Starting to collect Insights data for rhel-2e23a
Uploading Insights data.
Successfully uploaded report from rhel-2e23a to account 6227255.
View details about this system on cloud.redhat.com:
https://cloud.redhat.com/insights/inventory/1e06ad31-8eeb-4f29-8119-5689f72f8533
</pre>
