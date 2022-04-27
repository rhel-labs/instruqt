---
slug: step2
id: l1vry7nbntpq
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: cpudist
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 75
---
# Performance tuning for SQL Server

>**NOTE:** In this step we will be using the *cpudist* terminal to run tools and commands to optimize SQL Server on Red Hat Enterprise Linux.

Select the *cpudist* terminal to run commands in this step.

## RHEL tuned profiles ##
The tuned tuning service can adapt the operating system to perform better under certain workloads by setting a tuning profile. The `tuned-adm` command-line tool allows users to switch between different tuning profiles.

First, check the currently active tuned profile :

```
tuned-adm active
```

<pre class="file">
Current active profile: virtual-guest
</pre>

Tuned is enabled by default and auto selects a suitable profile. Since this machine is a VM, tuned selects the virtual-guest profile.

List all the tuned profiles that can be set:

```
tuned-adm list
```

<pre class="file">
Available profiles:
- balanced                    - General non-specialized tuned profile
- desktop                     - Optimize for the desktop use-case
- hpc-compute                 - Optimize for HPC compute workloads
- latency-performance         - Optimize for deterministic performance at the cost of increased power consumption
- network-latency             - Optimize for deterministic performance at the cost of increased power consumption, focused on low latency network performance
- network-throughput          - Optimize for streaming network throughput, generally only necessary on older CPUs or 40G+ networks
- powersave                   - Optimize for low power consumption
- throughput-performance      - Broadly applicable tuning that provides excellent performance across a variety of common server workloads
- virtual-guest               - Optimize for running inside a virtual guest
- virtual-host                - Optimize for running KVM guests
</pre>

RHEL has a tuned profile for Microsoft SQL Server called *mssql*. However, this profile is not available since we haven't installed this profile yet. To learn more about the tuned profiles listed above check [Monitoring and managing system status and performance](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/getting-started-with-tuned_monitoring-and-managing-system-status-and-performance#tuned-profiles-distributed-with-rhel_getting-started-with-tuned)

Next, let's install the mssql tuned profile:

```
yum install -y tuned-profiles-mssql
```

Again, list all the tuned profiles that can be set and notice that you have the mssql profile now available:

```
tuned-adm list
```

<pre class="file">
<< OUTPUT ABRIDGED >>

- latency-performance         - Optimize for deterministic performance at the cost of increased power consumption
- mssql                       - Optimize for MS SQL Server
- network-latency             - Optimize for deterministic performance at the cost of increased power consumption, focused on low latency network performance

<< OUTPUT ABRIDGED >>
</pre>

Now, let's view the contents of the installed mssql tuned profile.

```
cat /usr/lib/tuned/mssql/tuned.conf
```

<pre class="file">
<< OUTPUT ABRIDGED >>
...
[main]
summary=Optimize for MS SQL Server
include=throughput-performance

[vm]
transparent_hugepage.defrag=always

[sysctl]
vm.max_map_count=800000
kernel.numa_balancing=0
kernel.sched_latency_ns=60000000
kernel.sched_min_granularity_ns=15000000
kernel.sched_wakeup_granularity_ns=2000000
..
<< OUTPUT ABRIDGED >>
</pre>

The mssql tuned profile includes the througput-performance profile, and additionally tunes several other resources including the kernel CPU scheduler, transparent huge pages, and max virtual memory page count.

By increasing the CPU scheduling granularity, it allows the kernel to more often evaluate whether a running job should be switched for another process. This allows the SQL Server processes to be consistently scheduled when they require CPU time, thus increasing the performance of the database application.

Check out `man tuned-adm` if you are interested in more details about the `tuned-adm` tool.

## Monitoring performance using bcc-tools ##

BCC is a toolkit for creating efficient kernel tracing and manipulation programs, and includes several useful tools and examples.

Install the kernel-devel package for your currently running kernel and the bcc-tools packages.

```
yum install -y kernel-devel-$(uname -r) bcc-tools
```

>**NOTE:** In the command above, we embed the uname -r command to automatically determine, and embed, the version of the currently running kernel.

To learn more about the bcc-tools in Red Hat Enterprise Linux, check [Performance observability in practice with bcc-tools](https://lab.redhat.com/ebpf-tracing)

We will use the `cpudist` bcc-tool to monitor SQL Server performance in a later step.
