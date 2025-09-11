---
slug: step1
id: pi9qynmmxqqf
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to register a system with Red Hat Insights and resolve a recommendation provided for Microsoft SQL Server running on the machine.

    # Concepts included in this scenario:
    * Register a system with Red Hat Insights
    * View recommendations triggered for the system on cloud.redhat.com
    * Remediate a recommendation for the system running SQL Server
    * Validate resolution by running the commands suggested by Insights
    * Confirm that SQL Server is running at the end of this exercise

    # Example Usecase:
    A system administrator running SQL Server on RHEL, is not yet familiar with all the best practices to run SQL Server on RHEL. The system administrator depends on insights to provide the proactive insights to configure their SQL Server instance on RHEL.
tabs:
- id: lxphxi3vhxvd
  title: Terminal
  type: terminal
  hostname: rhel
- id: tmipx1v69pdi
  title: cloud.redhat.com
  type: website
  url: https://cloud.redhat.com
  new_window: true
difficulty: basic
timelimit: 3420
enhanced_loading: null
---
## Registering a machine to the Red Hat Insights service

Red Hat Insights is now included in every Red Hat Enterprise Linux subscription.

In most Red Hat Enterprise Linux 8 installations, the insights-client software will be installed by default.  However, the minimal package set does not include installing the insights-client package and it will likely need it installed.

Install the insights-client package on the machine.

```bash
yum -y install insights-client
```

Next, register your system with Red Hat Insights.

```bash
insights-client --register
```

<pre class=file>
Successfully registered host rhel-e6d30
Automatic scheduling for Insights has been enabled.
Starting to collect Insights data for rhel-e6d30
Uploading Insights data.
Successfully uploaded report from rhel-e6d30 to account 6227255.
View the Red Hat Insights console at https://cloud.redhat.com/insights/
</pre>

From the above output, you can observe that the system has been successfully registered with the Red Hat Insights service.  As part of the registration, the machine also uploads a report to the Red Hat Insights service so that it may be analyzed for any Insights.

For future reference, make note of your system hostname.

```bash
hostname
```

<pre class=file>
rhel-e6d30
</pre>

>_NOTE:_ Your hostname will be different than the one listed in the output above

At any time in the future, you can get information about Insights registration
by using the `--status` option to `insights-client`.

```bash
insights-client --status
```

<pre class=file>
System is registered locally via .registered file. Registered at 2019-08-14T14:12:37.638768
Insights API confirms registration.
</pre>

Check whether or not SQL Server is running on the machine.

```bash
systemctl status mssql-server.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: failed (Result: exit-code) since Tue 2020-03-10 03:29:37 EDT; 8min ago

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is __Failed (NOT running)__. Let's have insights tell us what might be the issue here.
