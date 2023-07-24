---
slug: review
id: ysyqwp3patkj
type: challenge
title: Reviewing system Insights
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---

After selecting your system from the Inventory page and reviewing some overall data about it, click on the _Advisor_ tab to view the Red Hat Insights data that applies to this host.

![Host Insights](../assets/host-homepage-v2.png)

There may be several recommendations listed for this system.  Scroll down through the list until you reach the one entitled _Decreased security: OpenSSH PermitRootLogin settings_

![SSH Root Login Decreased Vulnerability](../assets/sshrootlogininsights.png)

From the _Detected issues_ section of the recommendation, you can see that this recommendation is being triggered by the machine running with the `PermitRootLogin` setting set to `yes`.

![NetworkManager Insight issue](../assets/sshrootlogininsightsdetectedissue.png)

In the _Steps to resolve_ section of the recommendation, step-by-step guidance on how to resolve the issue is provided.  In this case, we will follow the recommendation to set `PermitRootLogin no`.
