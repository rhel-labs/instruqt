---
slug: step1
id: xrojnqzgpnpo
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to understand the basics of Performance Co-Pilot (PCP) in RHEL, and use PCP to analyze the performance of Microsoft SQL Server running on Red Hat Enterprise Linux

    # Concepts included in this scenario:
    * Install Performance Co-Pilot (PCP) packages on RHEL
    * Analyze critical system resources using PCP
    * Install Performance Metric Domain Agents (PMDA) for SQL Server
    * Analyze SQL Server performance by running a sample columnstore-based analytic query using SQL Server

    >**BACKGROUND:** The first step to solving performance issues is being able to diagnose the issue. If you don’t have performance metrics and the ability to analyze them, you’re just relying on guesswork. One of the popular tools for performance monitoring on Linux is Performance Co-Pilot (PCP), and we’ll show you how to get started using PCP on Red Hat Enterprise Linux to collect and analyze data to solve your performance mysteries.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3420
---
## Validate Environment and Install PCP

>**Note:** For this scenario, we have started installing SQL Server in the background. The background task will take between 2-5 minutes to complete.

Performance Co-Pilot (PCP) provides a large number of command-line and graphical tools, as well as libraries to support system-level performance monitoring and management. PCP's architecture and services are designed to centralize the monitoring of performance across complex distributed systems.

To check if SQL Server installation is complete, we can use the following command -

```bash
systemctl status mssql-server.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: active (running) since Monday 2019-07-15 19:24:18 EDT; 3h 59min left

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is **active (running)**.

Install the PCP packages using yum

```bash
yum install pcp-zeroconf -y
```

Start and enable the **PCP's Collector Daemon (PMCD)** to start collecting system performance data

```bash
systemctl start pmcd
```

```bash
systemctl enable pmcd
```

Check the status of the enabled PMCD service

```bash
systemctl status pmcd --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

 Loaded: loaded (/usr/lib/systemd/system/pmcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2021-03-11 13:18:12 EST; 6min ago

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is **active (running)**.
