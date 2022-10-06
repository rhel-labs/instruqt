---
slug: step4
id: uaseto3lbmdp
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 900
---
## Troubleshooting high memory usage

Over the course of this lab, you have enabled the PCP tools for CLI and web UI utilization. Now, you will put those pieces together to see what happens to a system while CPU constrained.

In the background, the server has kicked off a proces that is putting a heavy strain on the CPUs.