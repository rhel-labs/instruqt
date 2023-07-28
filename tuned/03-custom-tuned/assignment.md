---
slug: custom-tuned
id: w9vp4kwr60lz
type: challenge
title: Create a custom TuneD Profile
teaser: Create a custom TuneD Profile
notes:
- type: text
  contents: 'Step 3: Lets create a custom tuned profile'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

Before we start, let's take a look at what tuned profiles are available to install in case there is a better option for Microsoft SQL Server:

```bash
dnf list tuned-profiles*
```

<pre>

root@rhel:~# dnf list tuned-profiles*
Updating Subscription Management repositories.
Last metadata expiration check: 0:22:07 ago on Mon 06 Feb 2023 08:35:50 PM UTC.
Available Packages
tuned-profiles-atomic.noarch                                                          2.19.0-1.el9                                                 rhel-9-for-x86_64-appstream-rpms
tuned-profiles-cpu-partitioning.noarch                                                2.19.0-1.el9                                                 rhel-9-for-x86_64-baseos-rpms
tuned-profiles-mssql.noarch                                                           2.19.0-1.el9                                                 rhel-9-for-x86_64-appstream-rpms
tuned-profiles-oracle.noarch                                                          2.19.0-1.el9                                                 rhel-9-for-x86_64-appstream-rpms
tuned-profiles-postgresql.noarch                                                      2.19.0-1.el9                                                 rhel-9-for-x86_64-appstream-rpms
tuned-profiles-spectrumscale.noarch                                                   2.19.0-1.el9                                                 rhel-9-for-x86_64-appstream-rpms
root@rhel:~#

</pre>

Great news!  It looks like there is a tuned-profile specifically for mssql.  Lets go ahead and install it and see what it includes

```bash
dnf install tuned-profiles-mssql -y
```

Lets take a look at the contents of our new tuned profile:

```bash
cat /usr/lib/tuned/mssql/tuned.conf
```

<pre>

#
# tuned configuration
#

[main]
summary=Optimize for Microsoft SQL Server
include=throughput-performance

[cpu]
force_latency=5

[vm]
# For multi-instance SQL deployments use 'madvise' instead of 'always'
transparent_hugepages=always

[sysctl]
vm.swappiness=1
vm.dirty_background_ratio=3
vm.dirty_ratio=80
vm.dirty_expire_centisecs=500
vm.dirty_writeback_centisecs=100
vm.max_map_count=1600000
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048576
kernel.numa_balancing=0

[scheduler]
sched_latency_ns=60000000
sched_migration_cost_ns=500000
sched_min_granularity_ns=15000000
sched_wakeup_granularity_ns=2000000

</pre>

You will notice that the mssql profile is using `include` to bring in the settings from the throughput-performance profile and then updating tunables which are specific to Microsoft SQL Server

You will also notice that under the [vm] heading there is a comment which states that if you are running a multi-instance SQL deployment, you want to use `madvise` instead of `always` for the transparent_hugepages setting

Since the DBA informed us we will be doing that, let's go ahead and update that parameter via a custom tuned profile

First we will create the directory for the new TuneD profile

```bash
mkdir /etc/tuned/mssql-multi
```

Next we will create a tuned.conf that includes the mssql profile and overrides transparent_hugepages to `madvise`


Copy and paste the command below into __> Shell__.

```bash
cat << EOF > /etc/tuned/mssql-multi/tuned.conf
[main]
summary=MSSQL profile for multi-instance
include=mssql

[vm]
transparent_hugepages=madvise

EOF
```

Let's review our new tuned.conf to ensure it looks correct


```bash
cat /etc/tuned/mssql-multi/tuned.conf
```

<pre>
root@rhel:~# cat /etc/tuned/mssql-multi/tuned.conf
[main]
summary=MSSQL profile for multi-instance
include=mssql

[vm]
transparent_hugepages=madvise

root@rhel:~#
</pre>


Everything looks good!

In our next lesson, we are going to activate the new profile and validate our settings
