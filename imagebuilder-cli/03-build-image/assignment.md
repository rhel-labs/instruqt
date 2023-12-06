---
slug: build-image
id: zw0bwwqqffxk
type: challenge
title: Build a machine image
notes:
- type: text
  contents: |+
    # Building a machine image

    In this step you will build a machine image from the node-app-server blueprint definition you made in the previous step.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
---
# Building a machine image

Use the `composer-cli` command to start a compose based on the
node-app-server blueprint.  For this lab, you will use the output format
of __qcow2__. However, you could build many different types of images including:

| Output type      |  Details                |
|------------------|:-----------------------:|
| ami              |  Amazon EC2             |
| openstack        |  OpenStack image        |
| qcow2            |  qcow2 image            |
| rhel-edge-commit |  RHEL edge image        |
| tar              |  tar archive            |
| vhd              |  virtual hard disk      |
| vmdk             |  Virtual Machine disk   |


```
composer-cli compose start node-app-server qcow2
```

<pre class='file'>
Compose 00403772-ff12-43d4-b09a-bddf28f20709 added to the queue
</pre>

The compose, or build of the image, is tracked using a UUID, in the above
example output, 00403772-ff12-43d4-b09a-bddf28f20709.  Your UUID should be
different and unique to your build.

Composes are queued and completed in the order that they were received.  You
can look at the status of the queue using `composer-cli compose status`.

```
composer-cli compose status
```
<pre class='file'>
ID                                    Status   Time                      Blueprint        Version  Typw    Size
00403772-ff12-43d4-b09a-bddf28f20709  RUNNING  Tue Feb 16 16:21:08 2021  node-app-server  0.0.1    qcow2
</pre>

The status will display all queued (WAITING), running (RUNNING), and
completed (FINISHED) composes.

Please click `Next` to advance to the next challenge in this lab.
