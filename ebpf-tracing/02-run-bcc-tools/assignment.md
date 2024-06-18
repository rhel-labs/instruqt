---
slug: run-bcc-tools
id: dqensh4f7pzh
type: challenge
title: Run bcc tools to prepare for observing an active workload.
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
In this step, you will start running the bcc-tools to prepare for observing an active workload on the system.  In the lab environment there are several additional terminal tabs across the top of the interface, the names correspond to tools that you will run in this, and following steps.

First, you will validate the environment and that it is not currently using any eBPF calls.  To do this, you will install the `bpftool` utility.

```bash,run
dnf install -y bpftool
```

Next, run `bpftool` to see what eBPF programs are currently loaded in the kernel.  If there are no eBPF programs in use, the tool will return no output.

```bash,run
bpftool prog list | grep -A 3 cgroup
```

<pre class="file">
20: cgroup_device  tag 40ddf486530245f5  gpl
        loaded_at 2022-11-14T20:28:36+0000  uid 0
        xlated 504B  jited 309B  memlock 4096B
        pids systemd(1)
21: cgroup_skb  tag 6deef7357e7b4530  gpl
        loaded_at 2022-11-14T20:28:36+0000  uid 0
        xlated 64B  jited 54B  memlock 4096B
        pids systemd(1)
22: cgroup_skb  tag 6deef7357e7b4530  gpl
        loaded_at 2022-11-14T20:28:36+0000  uid 0
        xlated 64B  jited 54B  memlock 4096B
        pids systemd(1)
23: cgroup_device  tag ca8e50a3c7fb034b  gpl
        loaded_at 2022-11-14T20:28:37+0000  uid 0
        xlated 496B  jited 307B  memlock 4096B
        pids systemd(1)
24: cgroup_skb  tag 6deef7357e7b4530  gpl
        loaded_at 2022-11-14T20:28:37+0000  uid 0
        xlated 64B  jited 54B  memlock 4096B
        pids systemd(1)

<<< OUTPUT ABRIDGED >>>
</pre>

The tool likely provided output, similar to that displayed above. Reviewing that output, the eBPF tools already running are related to the cgroup2 implementation on the machine. You will add to this list by launching additional tools, but is always good to know what is already in-place on the system before adding additional tooling to the machine.

Now, observe the tabs for the terminal.

Click on the tab `gethostlatency`.
![gethostlatencytab.png](../assets/gethostlatencytab.png)

The tool `gethostlatency` has been launched for you by running `/usr/share/bcc/tools/gethostlatency`.

```bash,run
/usr/share/bcc/tools/gethostlatency
```

<pre class="file">
TIME      PID    COMM                  LATms HOST
</pre>

The `gethostlatency` bcc-tool is showing latency statistics on the `getaddrinfo()` and `gethostbyname()` system calls. Effectively, you get to see how long these system calls take and which hostnames the applications need IP addresses for. This can be useful for discovering network connections that your applications are making.

Next, click on the tab `tcplife`.
![tcplifetab.png](../assets/tcplifetab.png)

`tcplife` was launched with the following command:

```bash,run
/usr/share/bcc/tools/tcplife
```

The following header should now be displayed in the *tcplife* terminal, indicating the tool is running:

<pre class="file">
PID   COMM       LADDR           LPORT RADDR           RPORT TX_KB RX_KB MS
</pre>

`tcplife` will tell you data about established tcp connections. PID is the process ID of the process opening the connection.  COMM, the command that corresponds to the PID.  LADDR and LPORT reference the local address and port of the connection. RADDR and RPORT the remote address and port.  TX_KB and RX_KB are the amount of data Transmitted (in Kilobytes) and Received (in Kilobytes).  MS is the time of the connection, in milliseconds.
