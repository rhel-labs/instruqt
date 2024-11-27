---
slug: step4
id: fo8cabox6ogu
type: challenge
title: Step 4
tabs:
- id: h9iibsa7vxf2
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: 8umbmnn08fhe
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
enhanced_loading: null
---
# Verifying a Kernel Live Patch

To validate that you have properly applied the Kernel Live Patch, run the
same `kpatch list` command you ran on the first step.  You will notice that
this time the output is no longer blank.

```bash,run
kpatch list
```

<pre class="file">
Loaded patch modules:
kpatch_5_14_0_284_11_1_1_1 [enabled]

Installed patch modules:
kpatch_5_14_0_284_11_1_1_1 (5.14.0-284.11.1.el9_2.x86_64)
</pre>

From the list output, you can see that the kpatch installed in the previous
step has been applied to the system and is enabled.  Now, your system has
been updated to resolve the Critical CVEs in the systems running kernel.

On the next step, you will look deeper into the patch to see what CVEs were
resolved with the applied kpatch and where to find additional information
from Red Hat on these CVEs and mitigations.
