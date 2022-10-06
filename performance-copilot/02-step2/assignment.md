---
slug: step2
id: wqzwhuf3kjve
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

PCP can collect and show a host of different system kernel metrics.

To display all the enabled performance metrics and include a short description, you can use the `pminfo` command:

```bash
pminfo -t
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

The `pmval` utility takes any of the available metrics and reports them in ASCII tables.

For instance, this command reports idle processor utilization for each CPU on the host, every 1 second in a 5 second window :

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

You are also able to get a live view of performance in a top-like view:

```bash
pcp htop
```

Once you note the running processes, use CTRL+C to exit.

This step barely scratches the surface of what's available in the PCP command line tools. In the next step, we'll look at similar tools but from the Web Console.
