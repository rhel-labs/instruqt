---
slug: review-tuned
id: 2wwtr8pa7fkz
type: challenge
title: Start TuneD and review TuneD profiles
teaser: Start TuneD and review TuneD profiles
notes:
- type: text
  contents: 'Step 2: Start TuneD and review profiles'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

The first thing we want to do is start TuneD

```bash
systemctl start tuned
```

Now we can take a look at what profiles are available

```bash
tuned-adm list
```

Here's what the result should look similar to.

<pre>

<<< OUTPUT ABRIDGED >>>

Available profiles:
- accelerator-performance     - Throughput performance based tuning with disabled higher latency STOP states
- balanced                    - General non-specialized tuned profile
- desktop                     - Optimize for the desktop use-case
- hpc-compute                 - Optimize for HPC compute workloads
- intel-sst                   - Configure for Intel Speed Select Base Frequency
- latency-performance         - Optimize for deterministic performance at the cost of increased power consumption
- mssql                       - Optimize for Microsoft SQL Server
- network-latency             - Optimize for deterministic performance at the cost of increased power consumption, focused on low latency network performance
- network-throughput          - Optimize for streaming network throughput, generally only necessary on older CPUs or 40G+ networks
- optimize-serial-console     - Optimize for serial console use.
- powersave                   - Optimize for low power consumption
- throughput-performance      - Broadly applicable tuning that provides excellent performance across a variety of common server workloads
- virtual-guest               - Optimize for running inside a virtual guest
- virtual-host                - Optimize for running KVM guests
Current active profile: virtual-guest

<<< OUTPUT ABRIDGED >>>

</pre>

It looks like our active profile is `virtual-guest`

Let's go ahead and see what that profile includes


```bash
cat /usr/lib/tuned/virtual-guest/tuned.conf | grep -v \^#
```

<pre>

<<< OUTPUT ABRIDGED >>>


[main]
summary=Optimize for running inside a virtual guest
include=throughput-performance

[sysctl]
vm.dirty_ratio = 30

vm.swappiness = 30

<<< OUTPUT ABRIDGED >>>

</pre>

It looks like there is an include line that tells it to bring in all the changes from the throughput-performance profile and then it overrides two values `vm.dirty_ratio` and `vm.swappiness`


Let's take a look at what is in the `throughput-performance` profile


```bash
cat /usr/lib/tuned/throughput-performance/tuned.conf
```

You will notice that the throughput-performance profile has a lot of tunings, including the two mentioned in the virtual-guest profile

The benefit of using include in our profiles is that we can inherit all these settings and then just override the few we want to update in our new profile

The child profile settings will take precedence over the duplicate tunings in the parent profile

It is important to understand this concept since we will leverage this in the next step which is creating our own custom TuneD profile
