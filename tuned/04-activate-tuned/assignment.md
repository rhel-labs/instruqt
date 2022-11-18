---
slug: activate-tuned
id: cgjg8oes3kvs
type: challenge
title: Activate and validate custom TuneD Profile
teaser: Activated and validate custom TuneD Profile
notes:
- type: text
  contents: 'Step 4: Lets test our new custom tuned profile'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

Let's run `tuned-adm list` to confirm our new `mssql-multi` profile shows up


```bash
tuned-adm list
```
<pre>
Available profiles:
- accelerator-performance     - Throughput performance based tuning with disabled higher latency STOP states
- balanced                    - General non-specialized tuned profile
- desktop                     - Optimize for the desktop use-case
- hpc-compute                 - Optimize for HPC compute workloads
- intel-sst                   - Configure for Intel Speed Select Base Frequency
- latency-performance         - Optimize for deterministic performance at the cost of increased power consumption
- mssql                       - Optimize for Microsoft SQL Server
- mssql-multi                 - MSSQL profile for multi-instance
- network-latency             - Optimize for deterministic performance at the cost of increased power consumption, focused on low latency network performance
- network-throughput          - Optimize for streaming network throughput, generally only necessary on older CPUs or 40G+ networks
- optimize-serial-console     - Optimize for serial console use.
- powersave                   - Optimize for low power consumption
- throughput-performance      - Broadly applicable tuning that provides excellent performance across a variety of common server workloads
- virtual-guest               - Optimize for running inside a virtual guest
- virtual-host                - Optimize for running KVM guests
Current active profile: virtual-guest
</pre>

We can see our new mssql-multi profile is Available, so let's go ahead and activate it

```bash
tuned-adm profile mssql-multi
```

If we run `tuned-adm active` we should see that our active profile is mssql-multi now.

```bash
tuned-adm active
```

In order to validate that our customer override is working we can check the value of transparent_hugepages

```bash
cat /sys/kernel/mm/transparent_hugepage/enabled
```

In the output, it should show the bracket around madvise

<pre>
always [madvise] never
</pre>

And that is it!  You now have a good understanding of the benefits of TuneD and the knowledge to create and use custom and static TuneD profiles!
