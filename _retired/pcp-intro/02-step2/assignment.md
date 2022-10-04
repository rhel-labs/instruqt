---
slug: step2
id: l7xxbnhvzmxy
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Using PCP for system metrics

### Inspect the PCP configuration on the host

To inspect the PCP configuration and view a summary of the current PCP installation use the `pcp` command

```bash
pcp
```

<pre class="file">
Performance Co-Pilot configuration on be5455ac10c4:

 platform: Linux be5455ac10c4 4.18.0-240.el8.x86_64 #1 SMP Wed Sep 23 05:13:10 EDT 2020 x86_64
 hardware: 2 cpus, 1 disk, 1 node, 3688MB RAM
 timezone: EST+5
 services: pmcd
     pmcd: Version 5.1.1-4, 12 agents, 3 clients
     pmda: root pmcd proc pmproxy xfs linux nfsclient mmv kvm jbd2
           dm openmetrics
 pmlogger: primary logger: /var/log/pcp/pmlogger/be5455ac10c4/20210311.10.13
     pmie: primary engine: /var/log/pcp/pmie/be5455ac10c4/pmie.log

<< OUTPUT ABRIDGED >>
</pre>

The output shows the two main underlying components of PCP : **PCP's Collector Daemon (PMCD)** which organizes, collects, manages metric information, and the **Performance Metric Domain Agents (PMDAs)** which knows how to gather information for different services. The file paths for **pmlogger** (which archives logs of performance metric values) and **pmie** (inference engine for performance metrics) are also shown in the output.

## Available PCP Kernel metrics

PCP can collect and show a host of different system kernel metrics.

Display the kernel metrics on the host with a short description using `pminfo` :

```bash
pminfo -t kernel.all
```

<pre class="file">
<< OUTPUT ABRIDGED >>
kernel.all.nprocs [total number of processes (lightweight)]
kernel.all.pid_max [maximum process identifier from /proc/sys/kernel/pid_max]
kernel.all.cpu.user [total user CPU time from /proc/stat for all CPUs, including guest CPU time]
kernel.all.cpu.nice [total nice user CPU time from /proc/stat for all CPUs, including guest time]
kernel.all.cpu.sys [total sys CPU time from /proc/stat for all CPUs]
kernel.all.cpu.idle [total idle CPU time from /proc/stat for all CPUs]
kernel.all.cpu.intr [total interrupt CPU time from /proc/stat for all CPUs]
kernel.all.cpu.steal [total virtualisation CPU steal time for all CPUs]
kernel.all.cpu.guest [total virtual guest CPU time for all CPUs]
kernel.all.cpu.vuser [total user CPU time from /proc/stat for all CPUs, excluding guest CPU time]
kernel.all.cpu.guest_nice [total virtual guest CPU nice time for all CPUs]
kernel.all.cpu.vnice [total nice user CPU time from /proc/stat for all CPUs, excluding guest time]
kernel.all.cpu.wait.total [total wait CPU time from /proc/stat for all CPUs]
kernel.all.cpu.irq.soft [soft interrupt CPU time from /proc/stat for all CPUs]
kernel.all.cpu.irq.hard [hard interrupt CPU time from /proc/stat for all CPUs]
kernel.all.interrupts.total One-line Help: Error: One-line or help text is not available
kernel.all.interrupts.errors [interrupt error count from /proc/interrupts]
kernel.all.softirqs.total One-line Help: Error: One-line or help text is not available
<< OUTPUT ABRIDGED >>
</pre>

Check out `man pminfo` if you are interested in more details about the `pminfo` tool.

## Monitoring performance using PCP

The `pmrep` utility takes any of the available metrics and reports them in ASCII tables.

The command reports idle processor utilization for each CPU on the host, every 1 seconds in a 5 seconds window :

```bash
pmval -t 1 -T 5 kernel.percpu.cpu.idle
```

>**NOTE:** In the command above, if the hostname is not specified, it defaults to using `localhost`. By using the -h option, you can specify the hostname of a remote host to monitor for the specific metric.

<pre class="file">
metric:    kernel.percpu.cpu.idle
host:      ae6a0554552e
semantics: cumulative counter (converting to rate)
units:     millisec (converting to time utilization)
samples:   6
interval:  1.00 sec

              cpu0                  cpu1
               0.9694                0.9894
               0.9693                0.9993
               0.9692                0.9892
               0.9692                0.9891
</pre>

To learn more about the PCP in Red Hat Enterprise Linux, check [Performance observability in practice with bcc-tools](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/monitoring-performance-with-performance-co-pilot_monitoring-and-managing-system-status-and-performance)

We will use the `pmval` tool to monitor SQL Server performance in a later step.
