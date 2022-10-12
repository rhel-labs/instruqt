---
slug: step7
id: exmnks4vybca
type: challenge
title: Step 7 - Using `free` to view information about the system memory usage
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
# Using `free` to view information about the system memory usage

Processes require memory to run, so when the system is running low on free
memory it can slow down significantly. The `free` command is useful for quickly
getting a summary of memory usage.

```
free -h
```

The `-h` option outputs the information in a human-readable format.

<pre class=file>
           total       used      free    shared   buff/cache  available
Mem:       1.8Gi       156Mi     1.2Gi   16Mi     430Mi       1.5Gi
Swap:      3.9Gi       0B        3.9Gi
</pre>

Let's launch `top` again but this time we'll run it in the background by adding a `&`.

```
top &
```

<pre class=file>
top &
[1] 3567
</pre>

If the available memory is very low, the fourth column of `ps au` can be
used for finding which processes are the culprits. To sort the output by
memory usage, add the `--sort=-%mem` option:

```
ps au --sort=-%mem
```

<pre class=file>
ps -au --sort=-%mem
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        3566  0.0  0.1  61648  4028 pts/0    R+   19:46   0:00 ps -au --sort=-%mem
root        2406  0.0  0.1  26112  3816 pts/0    Ss   19:05   0:00 /bin/bash
root         805  0.0  0.0  16224  2112 ttyS0    Ss+  18:57   0:00 /sbin/agetty -o -p -- \u --keep
root         804  0.0  0.0  13656  1676 tty1     Ss+  18:57   0:00 /sbin/agetty -o -p -- \u --nocl
</pre>

Suppose you no longer needed `top` and wanted to free up the resources being
used by this process. One option would be to return to terminal that it is
running in and quit it. However, it is simpler in most cases to use the `kill`
command. The process ID shown in the `ps` output is how you refer to the process
when killing it. Kill the `top` process from this terminal:

```
kill -9 $(pidof top)
```

Here's what you should see in the terminal.

```
root@rhel:~# ps -au
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         820  0.0  0.0  13656  1716 tty1     Ss+  18:33   0:00 /sbin/agetty -o -p -- \u --nocl
root         821  0.0  0.0  16224  2060 ttyS0    Ss+  18:33   0:00 /sbin/agetty -o -p -- \u --keep
root        2533  0.0  0.1  26112  3760 pts/0    Ss   18:48   0:00 /bin/bash
root        2696  0.0  0.1  51632  3812 pts/0    T    18:52   0:00 top
root        2698  0.0  0.1  58728  3944 pts/0    R+   18:53   0:00 ps -au
root@rhel:~# kill -9 2696
root@rhel:~# ps -au
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         820  0.0  0.0  13656  1716 tty1     Ss+  18:33   0:00 /sbin/agetty -o -p -- \u --nocl
root         821  0.0  0.0  16224  2060 ttyS0    Ss+  18:33   0:00 /sbin/agetty -o -p -- \u --keep
root        2533  0.0  0.1  26112  3760 pts/0    Ss   18:48   0:00 /bin/bash
root        2699  0.0  0.1  58728  3920 pts/0    R+   18:53   0:00 ps -au
[1]+  Killed                  top
```

This does not show any output, but you can see that `top` is no longer running.

If you want more exercises on this topic, more information on process management
can be found in the [Service Admin Basics lab](https://lab.redhat.com/service-admin).
