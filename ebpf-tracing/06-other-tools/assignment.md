---
slug: other-tools
id: daqbjdvzake0
type: challenge
title: Learn about other tools utilizing eBPF
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
In this lab, you have now observed: host name resolution, tcp connection information, file activity (in real time), filesystem latency, and realtime hits and misses on the memory cache on a Red Hat Enterprise Linux 8 system. Tools utilizing eBPF, such as those shipped with bcc-tools in Red Hat Enterprise Linux 9, are very powerful and allow you quick access to information about the kernel and your systems.

Take a look at how many tools are provided by bcc-tools:

```bash
ls -l /usr/share/bcc/tools | wc -l
```

<pre class="file">
125
</pre>

The 125 tools, counted in the example above, can be easily inspected or even modified since they are actually Python scripts:

```bash
file /usr/share/bcc/tools/biolatency
```

<pre class="file">
/usr/share/bcc/tools/biolatency: Python script, ASCII text executable
</pre>

Each of the tools shipped in the bcc-tools package contains a portion written in C language which is the code of the eBPF program which, after compilation, is passed to the kernel via the bpf() system call and used for collection and analysis of the data. The Python script then reads output of this eBPF program and allows easy formatting or further processing.
