---
slug: pcp-system-metrics
id: wqzwhuf3kjve
type: challenge
title: Using PCP for System Metrics
tabs:
- id: 8mryg30xesm1
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Using PCP for system metrics
===

PCP can collect and show a host of different system kernel metrics.

To display all the enabled performance metrics and include a short description, you can use the `pminfo` command:

```bash,run
pminfo -t
```

<pre class="file">
...Output Truncated Throughout...
kernel.all.nprocs [total number of processes (lightweight)]
mem.util.used [used memory metric from /proc/meminfo]
network.interface.in.bytes [network recv read bytes from /proc/net/dev per network interface]
disk.dev.total [per-disk total (read+write) operations]
</pre>

As you can see, there are a lot of performance metrics (over 3400!). `pminfo` displays not only the performance metric name, but also a brief description of the data it collects. Check out `man pminfo` if you are interested in more details about the `pminfo` tool.

Monitoring performance using PCP
===

The `pmval` utility takes any of the available metrics and reports them in formatted output. The different metrics present varying forms and amounts of data, determined by the metric collected, not by the `pmval` command.

As an example, in the command below, command reports idle processor utilization metric (kernel.percpu.cpu.idle) for each CPU on the host, every 1 second (-t 1) during an overall 5 second time window (-T 5):

```bash,run
pmval -t 1 -T 5 kernel.percpu.cpu.idle
```

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
