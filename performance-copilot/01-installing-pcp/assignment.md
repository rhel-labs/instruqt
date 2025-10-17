---
slug: installing-pcp
id: sdpmhuxswwy4
type: challenge
title: Installing the PCP Tools
notes:
- type: text
  contents: |
    # Introduction to Performance Co-Pilot

    ## Goal:
    After completing this scenario, users will be able to understand the basics of Performance Co-Pilot (PCP) in RHEL, and use PCP to analyze system performance.

    ## Concepts included in this scenario:
    * Install Performance Co-Pilot (PCP) packages on RHEL
    * Analyze critical system resources using PCP

    ## Additional Reading
    * [Monitoring and managing system status and performance](https://access.redhat.com/documentation/gu-in/red_hat_enterprise_linux/9/html/monitoring_and_managing_system_status_and_performance/setting-up-pcp_monitoring-and-managing-system-status-and-performance#doc-wrapper)
    * [Performance observability in practice with bcc-tools](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/monitoring-performance-with-performance-co-pilot_monitoring-and-managing-system-status-and-performance)
tabs:
- id: uw8a7u4vz9xo
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
## Installing the PCP tools

Performance Co-Pilot (PCP) is a suite of tools, services, and libraries for collecting, visualizing, storing, and analyzing system-level performance measurements.

First step is to install the PCP packages using dnf:

```bash,run
dnf install -y pcp-zeroconf
```

This RPM includes a number of PCP-related tools as dependencies to the main pcp package. This is prefered in the case that you need to do deeper performance analysis.

Next, start and enable the **PCP's Collector Daemon (PMCD)** to start collecting system performance data:

```bash,run
systemctl enable --now pmcd
```

Check the status of the enabled PMCD service:

```bash,run
systemctl status pmcd --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

  Loaded: loaded (/usr/lib/systemd/system/pmcd.service; enabled; preset: disabled)
  Active: active (running) since Mon 2023-07-24 17:34:29 UTC; 17s ago

<< OUTPUT ABRIDGED >>
</pre>

As shown in the output snippet above, verify that your system's pmcd service is active and running.

Finally, look at the basic system information provided by the PCP command:

```bash,run
pcp
```

<pre class="file">
Performance Co-Pilot configuration on rhel:

 platform: Linux rhel 5.14.0-284.11.1.el9_2.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Apr 12 10:45:03 EDT 2023 x86_64
 hardware: 2 cpus, 2 disks, 1 node, 7685MB RAM
 timezone: UTC
 services: pmcd
     pmcd: Version 6.0.1-4, 12 agents, 6 clients
     pmda: root pmcd proc pmproxy xfs linux nfsclient mmv kvm jbd2
           dm openmetrics
 pmlogger: primary logger: /var/log/pcp/pmlogger/rhel/20230724.17.34
     pmie: primary engine: /var/log/pcp/pmie/rhel/pmie.log
</pre>

The output shows the two primary underlying components of PCP : **PCP's Collector Daemon (PMCD)** which organizes, collects, manages metric information, and the **Performance Metric Domain Agents (PMDAs)** which knows how to gather information for different services.