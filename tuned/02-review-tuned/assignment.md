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
Now that we have started TuneD, let's make sure that it is running without issues

```bash
systemctl status tuned
```

<pre>
● tuned.service - Dynamic System Tuning Daemon
     Loaded: loaded (/usr/lib/systemd/system/tuned.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-11-21 19:34:13 UTC; 3min 7s ago
       Docs: man:tuned(8)
             man:tuned.conf(5)
             man:tuned-adm(8)
   Main PID: 2087 (tuned)
      Tasks: 4 (limit: 21954)
     Memory: 13.4M
        CPU: 330ms
     CGroup: /system.slice/tuned.service
             └─2087 /usr/bin/python3 -Es /usr/sbin/tuned -l -P

Nov 21 19:34:13 rhel systemd[1]: Starting Dynamic System Tuning Daemon...
Nov 21 19:34:13 rhel systemd[1]: Started Dynamic System Tuning Daemon.
</pre>

We can see that the status is active (running) and that the service is enabled

Lets take a look at what profiles are available

```bash
tuned-adm list
```

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

The default profiles are kept in /usr/lib/tuned, so lets go ahead and see what the virtual-guest profile includes


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

You will notice that there is a line that says 'include' which tells TuneD to bring in all the tunings from the throughput-performance profile and then later updates two values `vm.dirty_ratio` and `vm.swappiness`


Let's take a look at what is in the `throughput-performance` profile


```bash
cat /usr/lib/tuned/throughput-performance/tuned.conf | grep -v \^#
```

You will notice that the throughput-performance profile has a lot of tunings, including the two mentioned in the virtual-guest profile

The benefit of using include in our profiles is that we can inherit all these settings and then just override the few we want to update in our new profile

The child profile settings will take precedence over the duplicate tunings in the parent profile

It is important to understand this concept since we will leverage this in the next step which is creating our own custom TuneD profile
