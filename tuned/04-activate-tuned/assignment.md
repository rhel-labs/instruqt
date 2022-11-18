---
slug: activate-tuned
type: challenge
title: Activate and validate custom TuneD Profile
teaser: Activated and validate custom TuneD Profile
notes:
- type: text
  contents: 'Step 4: Let's test our new custom tuned profile'
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
Current active profile: virtual-guesti


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

always [madvise] never

And that is it!  You now have a good understanding of the benefits of TuneD and the knowledge to create and use custom and static TuneD profiles!















**** OLD STUFF
You will notice here that we are including the throughput-performance profile like the virtual-guest profile did, but we have a lot more tunables which are specific to Microsoft SQL Server

You will also notice that under the [vm] heading there is a comment that if you are running a multi-instance SQL deployment, you want to use `madvise` instead of `always` for the transparent_hugepages setting.

Let’s do that via a custom TuneD profile

Since we know that the mssql profile has all the settings we need and we just want to override one variable, we can create a new TuneD profile, include the mssql profile and then override the transparent_hugepages to madvise

First lets create the directory for the new TuneD profile


Copy and paste the command below into __> Shell__.

```bash
mkdir /etc/tuned/mssql-multi
```

Next we will create a tuned.conf that includes the mssql profile and overrides transparent_hugepages to `madvise`

Copy and paste the command below into __> Shell__.

```bash
printf "[main]\nsummary=MSSQL profile for multi-instance\ninclude=mssql\n\n[vm]\ntransparent_hugepages=madvise\n" > /etc/tuned/mssql-multi/tuned.conf
```

Let's take a look at our new tuned.conf

Copy and paste the command below into __> Shell__.

```bash
cat /etc/tuned/mssql-multi/tuned.conf
```

In our next lesson, we are going to activate the new profile and validate our settings

