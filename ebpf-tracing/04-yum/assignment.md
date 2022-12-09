---
slug: yum
id: scl11igw2rcz
type: challenge
title: Observing yum performance
tabs:
- title: yum
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "yum" > /dev/null 2>&1
- title: gethostlatency
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "gethostlatency" > /dev/null 2>&1
- title: tcplife
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "tcplife" > /dev/null 2>&1
- title: filetop
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "filetop" > /dev/null 2>&1
- title: xfsslower
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "xfsslower" > /dev/null 2>&1
- title: cachestat
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "cachestat" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
Time to observe what happens when `yum` does an update from a system perspective! In the `yum` tab run:

```bash
yum update -y
```

The first thing that `yum` does is updates repository metadata. This is going to create activity on your *gethostlatency* terminal and your *tcplife* terminal as the data is being downloaded from the Red Hat Content Delivery Network (CDN). You can look at those tool outputs to see the network connections that the `yum update` establishes in real time.

You will see entries on our *gethostlatency* tab similar to:

<pre class="file">
TIME      PID    COMM                  LATms HOST
08:45:23  75923  yum                    0.10 localhost
08:45:25  75924  yum                  375.39 subscription.rhsm.redhat.com
08:45:27  75926  yum                  109.50 subscription.rhsm.redhat.com
08:45:38  75927  yum                   10.23 cdn.redhat.com
08:45:39  75929  yum                   10.21 cdn.redhat.com
08:45:40  75931  yum                   10.18 cdn.redhat.com
</pre>

these show `yum` looking up IP addresses for localhost, subscription.rhsm.redhat.com, and cdn.redhat.com. `gethostlatency` makes it really easy to know what hosts our application is talking to.

Also look at the *cachestat* tab and you should see output similar to:

<pre class="file">
    HITS   MISSES  DIRTIES  BUFFERS_MB  CACHED_MB
      14        0        0           0       1681
    2768        0        0           0       1699
     596        0        0           0       1700
    4143        0        0           0       1708
    3252        0        0           0       1698

<< OUTPUT ABRIDGED >>
</pre>

This shows that you are operating entirely on system cache and not having to retrieve data from storage at this point in the operation.

Look at your *tcplife* tab when `yum` has finished downloading packages.  You will see output similar to the sample below:

<pre class="file">
PID   COMM       LADDR           LPORT RADDR           RPORT TX_KB RX_KB MS
75963 yum        172.17.0.39     38054 2.16.30.83      443      23 138393 36375.04
75963 yum        172.17.0.39     38054 2.16.30.83      443      24 163378 36374.62
75963 yum        172.17.0.39     38054 2.16.30.83      443      22 163223 36374.69
</pre>

The output shows you that `yum` has established a connection on port 443 to IP address 2.16.30.83. Further, according to the sample output above, that connection lasted for 36375.04 milliseconds, or 36.37504 seconds. This correlates to the amount of time `yum` spent downloading packages.

