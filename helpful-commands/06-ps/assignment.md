---
slug: ps
id: c2xebnl6zqg1
type: challenge
title: Viewing processes
tabs:
- id: tsqqcnmhlfdl
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

Just as files organize how data is stored on Linux, processes organize all of the programs that are running on the system. The `ps` command (short for Process Status) will display information about the processes running in the current shell. To see all of the processes running on the system and present them in a user-readable format, it is common to add the `aux` options to `ps`.

```bash
ps aux
```

<pre class=file>
root           1  0.0  0.7 186400 14448 ?        Ss   15:38   0:11 /usr/lib/systemd/systemd --switched-root --system --deserialize 17
root           2  0.0  0.0      0     0 ?        S    15:38   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   15:38   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   15:38   0:00 [rcu_par_gp]
root           6  0.0  0.0      0     0 ?        I<   15:38   0:00 [kworker/0:0H-events_highpri]
root           9  0.0  0.0      0     0 ?        I<   15:38   0:00 [mm_percpu_wq]
root          10  0.0  0.0      0     0 ?        S    15:38   0:00 [ksoftirqd/0]
root          11  0.0  0.0      0     0 ?        I    15:38   0:00 [rcu_sched]

<< OUTPUT ABRIDGED >>
</pre>

>_NOTE:_ There is another lab which goes into depth about `ps` and process management. For more info on using `ps` (including how to end processes), check out the [Service Administration Basics lab](https://lab.redhat.com/service-admin)

The output of this command is often very lengthy, so this is a great chance to apply what you just learned a few steps ago. Using the pipe operator (`|`), pipe the output of `ps aux` into the `grep` command to search for a specific process. Search for the `sshd` process.:

```bash
ps aux | grep sshd
```

<pre class=file>
root        1441  0.0  0.2  16120  9688 ?        Ss   14:35   0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        1708  0.0  0.0   6412  2116 pts/0    S+   14:47   0:00 grep --color=auto sshd
</pre>

Here the search finds the `sshd` process, but the second line of this output shows that the search also finds itself.

`ps` is great for showing a snapshot of the active processes and their resource usage, but sometimes it is more useful to have a utility that keeps updating this information in real time. `top` does just that.

```bash
top
```

<pre class=file>
top - 21:11:07 up  4:10,  2 users,  load average: 0.45, 0.16, 0.06
Tasks: 114 total,   1 running, 113 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.3 sy,  0.0 ni, 99.3 id,  0.2 wa,  0.2 hi,  0.0 si,  0.0 st
MiB Mem :   1817.0 total,   1135.0 free,    181.5 used,    500.5 buff/cache
MiB Swap:   4000.0 total,   4000.0 free,      0.0 used.   1482.2 avail Mem

  PID USER    PR  NI   VIRT   RES   SHR S %CPU %MEM    TIME+ COMMAND
 2940 root    20  0       0     0     0 I  0.3  0.0  0:00.01 kworker/u4:2-flush-253:0
15893 root    20  0   65416  4736  3952 R  0.3  0.3  0:00.04 top
    1 root    20  0  187008  4968  9800 S  0.0  0.8  0:03.06 systemd
    2 root    20  0       0     0     0 S  0.0  0.0  0:00.01 kthreadd
    3 root     0 -20      0     0     0 I  0.0  0.0  0:00.00 rcu_gp
</pre>

In addition to the process info, `top` includes some status information:
* The system uptime
* Total number of user accounts
* 1 minute, 5 minute, and 15 minute load averages
* The total number of tasks and a breakdown of their status counts
* The kinds of tasks using the CPU
* A breakdown of memory and swap usage

>_NOTE:_ For more information on the `top` preamble, visit section 2 of the [top man page](https://man7.org/linux/man-pages/man1/top.1.html).

This output will continue updating until you quit `top`. To quit `top` press `q`.
