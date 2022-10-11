---
slug: step1
id: icype1zq2slg
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:

    After completing this scenario, users will better understand the performance observability tools provided in Red Hat Enterprise Linux.

    # Concepts included in this scenario:
    * Install bcc-tools
    * Using bpftool to verify use of eBPF
    * Run trivial eBPF tracing tools to get familiar with the concept

    # Example Usecase:

    In this lab, you are going to use tools from the bcc-tools package to analyse what happens on a system during a `yum update`. We picked `yum update` because it represents a non-trivial, real world application. In a `yum update`, the following activity happens:

    * TCP connections are established to configured repositories, which you will track with `gethostlatency` and `tcplife`.
    * Many files will be opened on your XFS filesystem, which you will observe with `filetop`. You will also use `xfsslower` to determine which XFS operations take longer than 10ms to execute.
    * Memory access. Linux uses a memory cache to ensure faster access to needed information than having to go to disk. Using `cachestat`, you will be able to see hits and misses on this cache in realtime. When everything Linux needs is cached, you should observe zero misses and while the cache is being populated, you will see a number of misses. If the cache continues to be populated beyond the size of the cache, Linux will employ a LRU (Least Recently Used) algorithm with a lot of heuristics and some cached data will be removed and replaced with new data.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3420
---
eBPF is an in-kernel virtual machine that allows code execution in the kernel space, in a restricted sandbox environment with access to a limited set of functions. The virtual machine executes special assembly-like code. The code is then loaded in the kernel and translated to the native machine code with just-in-time compilation. There are numerous components shipped by Red Hat that utilize the eBPF virtual machine.

The bcc-tools package provides many pre-created tools that provide data from functions built with eBPF.

>**Note:** In the `Terminal` tab in the upper left corner of the Instruqt web page, there are 6 shell sessions launched. To switch between the 6 shell sessions, press Ctrl-B and an arrow key pointing to the session you wish to become active.

First, in pane 5, install the kernel-devel package for your currently running kernel and the bcc-tools packages.

![Terminal Pane 5](../assets/pane5.png)

Enter the following command:

```bash
yum install -y kernel-devel-$(uname -r) bcc-tools
```

>**Note:** In the command above, we embed the `uname -r` command to automatically determine, and embed, the version of the currently running kernel.

Next, inspect the content of the bcc-tools package to see some of the pre-built tool catalog that is provided.  Each of these tools has a `man` page which provides details on what data the tool produces as well as any options that may be used when running the tool.

```bash
rpm -ql bcc-tools | grep /usr/share/bcc/tools/
```

<pre class="file">
/usr/share/bcc/tools/argdist
/usr/share/bcc/tools/bashreadline
/usr/share/bcc/tools/biolatency
/usr/share/bcc/tools/biosnoop

<< OUTPUT ABRIDGED >>
</pre>

You will be working with several of these tools in the next steps.  The
tools provided by the bcc-tools package are installed in the
/usr/share/bcc/tools directory.
