---
slug: manage-snapshots
id: k4exme7lkohv
type: challenge
title: Manage storage
teaser: Manage storage on your RHEL hot with Stratis.
notes:
- type: text
  contents: 'Step 2: Manage storage with Stratis.'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
---
This lab simulates block devices so we won't be using actual drives. This limitation has no material effect on how Stratis would manage real block devices on a server or VM.

Use the command `lsblk`.

```
lsblk
```

Stratis consists of two components.

First, the Stratis daemon, stratisd:
- manages collections of block devices
- provides a D-Bus API

Second, the Stratis command-line interface, stratis-cli:
- uses the D-Bus API to communicate with stratisd

To start off, install the stratisd and stratis-cli packages using a software package manager.

```
yum -y install stratisd stratis-cli
```

You can check the stratis-cli version.

```
stratis --version
```
