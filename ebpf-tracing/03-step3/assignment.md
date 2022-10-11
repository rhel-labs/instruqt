---
slug: step3
id: 80mgxsbvhor0
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Let's launch two more bcc-tools in separate terminals before you start observing the sample workload:

Run `filetop` in __pane 2__ in the terminal:

```bash
/usr/share/bcc/tools/filetop
```

In __pane 2__ in the terminal, you should see a top-like tool that refreshes every second with a header that looks like the example below:

<pre class="file">
09:08:28 loadavg: 0.26 0.48 0.72 1/817 76893

TID    COMM           READS  WRITES R_Kb     W_Kb    T FILE
</pre>

If you see this, you know that the tool is properly running.  This tool will track the count of READS and WRITES as well as the size, R_Kb and W_Kb, respectively.  Additionally, it includes the type, T, of file and the FILE itself that is interacted with by the command, COMM.

In __pane 2__ in the terminal, you are going to see applications accessing files in realtime, so this will get pretty busy.

Now run the `xfsslower` tool in __pane 3__ in the terminal:

```bash
/usr/share/bcc/tools/xfsslower
```

You should see the header below in __pane 3__ in the terminal, indicating that the tool is properly running:

<pre class="file">
Tracing XFS operations slower than 10 ms
TIME     COMM           PID    T BYTES   OFF_KB   LAT(ms) FILENAME
</pre>

In __pane 3__ in the terminal, you probably will not see much until the sample workload, a `yum update`, begins. Once it starts to install the packages, it is going to start showing output operations taking longer than 10ms, LAT(ms), and the files, FILENAME, these operations are operating upon.  The sample workload will push the boundaries of what our virtual machine's storage can keep up with which is why XFS operations will start taking over the 10ms latency threshold used by this tool for reporting slower operations.

Lastly, run the `cachestat` tool in __pane 4__ in the terminal:

```bash
/usr/share/bcc/tools/cachestat
```

You should see the following header in the *cachestat* terminal, indicating that the tool is properly running:

<pre class="file">
    HITS   MISSES  DIRTIES  BUFFERS_MB  CACHED_MB
</pre>

In the *cachestat* terminal, you will get to see, in real time, the hits and misses on the Linux memory cache. The second column is MISSES, and the third column is HITS. You should see mostly 0 misses for the first part of the `yum update` workload. However, once you get to the installation of packages, you should see your misses start to increase as the operations start to interact with files on disk and other data not already cached in system memory.

Now that you have setup several tools, use `bpftool` to verify what you have loaded in the kernel. Change focus to __pane 5__ in the terminal and run the following:

```bash
bpftool prog list | less
```

You should see output similar to the sample below:

<pre class="file">
1: kprobe  name do_entry  tag 8ac728a12cedba65  gpl
        loaded_at 2020-02-19T19:07:30-0500  uid 0
        xlated 2352B  jited 1408B  memlock 4096B
2: kprobe  name do_return  tag 6deef7357e7b4530  gpl
        loaded_at 2020-02-19T19:07:30-0500  uid 0
        xlated 64B  jited 61B  memlock 4096B
3: tracepoint  name sock__inet_sock  tag 6deef7357e7b4530  gpl
        loaded_at 2020-02-19T19:07:30-0500  uid 0
        xlated 64B  jited 61B  memlock 4096B

<< OUTPUT ABRIDGED >>
</pre>

This shows you all the bpf programs presently loaded. Press "q" to exit.

Now you are set up with several eBPF observability tools running and in the next step, you will begin observing the `yum update` sample workload.
