---
slug: installnmstate
id: 7dbqce8udp7z
type: challenge
title: Install NMState
notes:
- type: text
  contents: |
    We'll install `NMState` to capture our current networking configuration.
tabs:
- title: Host 1
  type: terminal
  hostname: host1
difficulty: basic
timelimit: 60
---
## What is nmstate?

NMState is a library with an accompanying command line tool that manages host networking settings. NMState is a convenient way to capture network settings into an easily readable yaml file.

To install NMState, run the following command in the CLI.

```bash
dnf install -y nmstate
```

![nmstateinstall](../assets/nmstateinstall.png)

We'll use NMState later on in this lab.
