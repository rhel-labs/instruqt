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

As we mentioned in the beginning, TuneD is distributed with a number of predefined profiles

During the installation, a profile for your system is automatically selected based on the system information.  For example, it may detect
that you are a virtual-guest and it will select that profile for you.  However, you may decide that you would rather run something else that has
a specific performance or power profile instead.

Lets take a look at what profiles are available so we can determine what is available by default:

```bash
tuned-adm list profiles
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

It looks like our active profile is `virtual-guest` as stated on the last line, and there are a handful of profiles available to enable as well which are listed under the Available profiles

The default profiles are kept in /usr/lib/tuned, so lets go ahead and see what the virtual-guest profile includes:


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

One of the great things about TuneD profiles are the ability to inherit tunings from another profile. You will notice that on the output there is a line that starts with `include`.  This means you will bring in all the settings for the throughput-performance profile in this virtual-guest profile and then update two values `vm.dirty_ratio` and `vm.swappiness` which are defined under the [sysctl] heading


Lets take a look at what is in the `throughput-performance` profile


```bash
cat /usr/lib/tuned/throughput-performance/tuned.conf | grep -v \^#
```

You will notice that the throughput-performance profile has a lot of tunings, including the two mentioned in the virtual-guest profile

The benefit of using include in our profiles is that we can inherit all these settings and then just override the few we want to update in our new profile

The child profile settings will take precedence over the duplicate tunings in the parent profile

Lets move forward with the next step and create our own TuneD profile and customize it for our use case