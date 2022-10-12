---
slug: step3
id: igqtjxgajzfl
type: challenge
title: Step 3
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
# Generate CPU-hot workload

**stress-ng** can stress various system resources such as CPU, cache, disk, memory, socket pipe I/O, scheduling and much more.

Stress-ng has a wide range of CPU specific stress tests that exercise floating point, integer, bit manipulation and control flow. In this step of the lab, we will use the CPU-intensive matrix stressor, which is one of the many tests that heats CPUs the best.

Using the terminal window,  the stress-ng matrix stressor -

```
stress-ng --matrix 0 -t 45s
```

The stressor should run for a 45-second duration and will drive up CPU utilization across both the v-CPUs on the instance.

<pre class="file">
stress-ng: info:  [47161] dispatching hogs: 2 matrix
stress-ng: info:  [47161] successful run completed in 45.00s
</pre>

While stress-ng is still running, you will see that the 2 CPUs are hot on the CPU tile in the web console

![Look at CPU Activity](../assets/CPU_hot_at_a_glance.png)

The CPU graph will also be updated with the **CPU spike** message and graph
