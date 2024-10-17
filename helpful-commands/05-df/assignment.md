---
slug: df
id: sduycmmpj4rb
type: challenge
title: Using `df` to check disk usage
tabs:
- id: uldf0yggx8in
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

A large part of a system administrator's job is to be able to diagnose what is causing a system to misbehave. Disk space being full can lead to unexpected behavior, so the `df` command is great to include in any troubleshooting session.

The `df` command, short for "disk free", shows a breakdown of disk usage.
The `-h` option will present the sizes in a human readable format:

```bash
df -h
```

<pre class=file>
Filesystem             Size  Used Avail Use% Mounted on
devtmpfs               890M     0  890M   0% /dev
tmpfs                  909M     0  909M   0% /dev/shm
tmpfs                  909M  8.5M  901M   1% /run
tmpfs                  909M     0  909M   0% /sys/fs/cgroup
/dev/mapper/rhel-root   35G  4.5G   30G  14% /
/dev/vda1             1014M  197M  818M  20% /boot
tmpfs                  182M     0  182M   0% /run/user/0
</pre>

The usage percentage (_Use%_) column is a great place to start. If any filesystem is close to capacity, then it may be unable to perform installations or other operations that require data to be written. However, the absolute size of the partition will determine what "close to capacity" means. In the case of this system, the root partition is 35 GiB. Therefore, even if it is at 80% usage, the filesystem will still have 7 GiB to work with. Probably something you need to address eventually, but unless you are doing some storage-intensive operation that is failing, likely not the cause of immediate issues.

The _boot_ partition is on the other end of the spectrum, with a size of only 1014 MiB. Therefore, if this filesystem is at 80% usage, there will only be 200 MiB available. That may not be enough for basic operations such as installing system updates. Therefore, it is very concerning if you run `df` and discover one of the smaller filesystems is at 80% usage.

>_NOTE:_ The _tmpfs_ entries are filesystems accessible by the machine that are stored in RAM. This means that you don't have to care as much about these filesystems when troubleshooting using `df`. A reboot will give you a fresh copy of these filesystems.
