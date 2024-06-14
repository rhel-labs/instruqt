---
slug: file-ops
id: 80mgxsbvhor0
type: challenge
title: Observing File operations
tabs:
- title: dnf
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
Let's explore two more bcc-tools in separate terminal tabs before you start observing the sample workload:

Click on the `filetop` tab.

![filetop](../assets/filetoptab.png)

The `filetop` tool was launched by running the following command.

```bash,run
/usr/share/bcc/tools/filetop
```

You should see a top-like tool that refreshes every second with a header that looks like the example below:

<pre class="file">
09:08:28 loadavg: 0.26 0.48 0.72 1/817 76893

TID    COMM           READS  WRITES R_Kb     W_Kb    T FILE
</pre>

If you see this, you know that the tool is properly running.  This tool will track the count of READS and WRITES as well as the size, R_Kb and W_Kb, respectively.  Additionally, it includes the type, T, of file and the FILE itself that is interacted with by the command, COMM.

In the `filetop` tab in the terminal, you are going to see applications accessing files in realtime, so this will get pretty busy.

Now click the `xfsslower` tab.

The `xfsslower` tool was run with the following command.

```bash,run
/usr/share/bcc/tools/xfsslower
```

You should see the header below in the `xfsslower` tab, indicating that the tool is properly running:

<pre class="file">
Tracing XFS operations slower than 10 ms
TIME     COMM           PID    T BYTES   OFF_KB   LAT(ms) FILENAME
</pre>

You probably will not see much until the sample workload, a `yum update`, begins. Once it starts to install the packages, it is going to start showing output operations taking longer than 10ms, LAT(ms), and the files, FILENAME, these operations are operating upon.  The sample workload will push the boundaries of what our virtual machine's storage can keep up with which is why XFS operations will start taking over the 10ms latency threshold used by this tool for reporting slower operations.

Lastly, click the `cachestat` tab.

We have not yet launched `cachestat`.

Run the following command.

```bash,run
/usr/share/bcc/tools/cachestat
```

You should see the following header in the *cachestat* terminal, indicating that the tool is properly running:

<pre class="file">
    HITS   MISSES  DIRTIES  BUFFERS_MB  CACHED_MB
</pre>

In the *cachestat* terminal, you will get to see, in real time, the hits and misses on the Linux memory cache. The second column is MISSES, and the third column is HITS. You should see mostly 0 misses for the first part of the `dnf update` workload (which you have not run yet). However, once you get to the installation of packages, you should see your misses start to increase as the operations start to interact with files on disk and other data not already cached in system memory.

Now you are set up with several eBPF observability tools running and in the next step, you will begin observing the `dnf update` sample workload.
