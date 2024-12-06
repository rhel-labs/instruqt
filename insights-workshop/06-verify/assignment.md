---
slug: verify
id: b1upagrvqxd9
type: challenge
title: Verify issue resolved
tabs:
- id: dupgbnkkkyeq
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---

Finally, reload the system page in your web browser.
Look to verify that the recommendation is no longer displayed for your system.
![Remediation completed](../assets/remediation-complete.png)