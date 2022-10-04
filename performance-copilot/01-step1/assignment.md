---
slug: step1
id: sdpmhuxswwy4
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Introduction to Performance Co-Pilot

    ## Goal:
    After completing this scenario, users will be able to understand the basics of Performance Co-Pilot (PCP) in RHEL, and use PCP to analyze system performance.

    ## Concepts included in this scenario:
    * Install Performance Co-Pilot (PCP) packages on RHEL
    * Analyze critical system resources using PCP
    * Using Web Console to review PCP data

    ## Additional Reading
    * [Monitoring and managing system status and performance](https://access.redhat.com/documentation/gu-in/red_hat_enterprise_linux/9/html/monitoring_and_managing_system_status_and_performance/setting-up-pcp_monitoring-and-managing-system-status-and-performance#doc-wrapper)
    * [Performance observability in practice with bcc-tools](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/monitoring-performance-with-performance-co-pilot_monitoring-and-managing-system-status-and-performance)
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Installing the PCP tools

Performance Co-Pilot (PCP) is a suite of tools, services, and libraries for monitoring, visualizing, storing, and analyzing system-level performance measurements.

Install the PCP packages using dnf:

```bash
dnf install -y pcp-zeroconf
```

Start and enable the **PCP's Collector Daemon (PMCD)** to start collecting system performance data:

```bash
systemctl enable --now pmcd
```

Check the status of the enabled PMCD service:

```bash
systemctl status pmcd --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

 Loaded: loaded (/usr/lib/systemd/system/pmcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2021-03-11 13:18:12 EST; 6min ago

<< OUTPUT ABRIDGED >>
</pre>

Verify that the Active status is **active (running)**. Finally, look at the basic system information provided by the PCP command:

```bash
pcp
```

The output shows the two main underlying components of PCP : **PCP's Collector Daemon (PMCD)** which organizes, collects, manages metric information, and the **Performance Metric Domain Agents (PMDAs)** which knows how to gather information for different services. The file paths for **pmlogger** (which archives logs of performance metric values) and **pmie** (inference engine for performance metrics) are also shown in the output.