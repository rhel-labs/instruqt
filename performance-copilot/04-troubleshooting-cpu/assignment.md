---
slug: troubleshooting-cpu
id: uaseto3lbmdp
type: challenge
title: Troubleshooting High CPU
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
## Troubleshooting high CPU usage

Over the course of this lab, you have enabled the PCP tools for CLI and web UI utilization. Now, you will put those pieces together to see what happens to a system while CPU constrained.

In the background, the server has kicked off a proces that is putting a heavy strain on the CPUs. You will first use the CLI to identify this process then also with the web console.

Let's launch a process that will generate a heavy strain on the CPUs. In the `Terminal`, run the following:

```bash
nohup /usr/bin/stress-ng --cpu 2 > stress.out 2> stress.err < /dev/null & disown
```

One of the quickest ways to assertain the root of the problem is with a live view of performance in a top-like interface:

```bash
pcp htop
```

Note that both CPUs are reporting 100%. The table below will show the heaviest proceses in terms of CPU. Once you note the PID (Process Identifier) of the top process, use CTRL+C to exit.

<a href="#1">
 <img alt="An example image" src="../assets/htop.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/htop.png" />
</a>

With this PID, you can investigate further or utiilize it in a kill command. However, before you kill the runaway process, switch to the Web Console tab.

You will notice on the Performance Metrics screen that the live performance graphs have indicated a CPU spike. You are able to see when the spike began as well as click on the `>` to gain additional insights

<a href="#2">
 <img alt="An example image" src="../assets/cpu_spike.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/cpu_spike.png" />
</a>

Click on `View all logs`.

This will output log entries and time stamps that help you walk back to what caused the spike to begin. Notice that the `stress-ng` process has been identified as the root cause.

This lab barely scratches the surface of what's available in the PCP command line tools. For more information please visit our documentation: [Monitoring and managing system status and performance](https://access.redhat.com/documentation/gu-in/red_hat_enterprise_linux/9/html/monitoring_and_managing_system_status_and_performance/setting-up-pcp_monitoring-and-managing-system-status-and-performance#doc-wrapper)

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
