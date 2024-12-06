---
slug: introduction
id: 2wh6iit1xsud
type: challenge
title: Introduction to the lab
teaser: Learn about the components of this lab.
notes:
- type: text
  contents: |
    # Learn about the components of this lab.

    # Lab Feedback
    If you would like to report any bugs or make suggestions on how we can improve our labs, [please leave us a message here](https://github.com/rhel-labs/instruqt/discussions/categories/general).

    # YouTube
    For more information about Red Hat Enterprise Linux, we invite you to view our [YouTube channel]([**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)). [**red.ht/rhel-youtube**](https://red.ht/4etqJ1T)

    If you are interested in learning critical administration skills for Red Hat Enterprise Linux, you might be interested in our show [Into the Terminal](https://www.youtube.com/playlist?list=PLXJyD2dL4oqeX-C3MvsMUJuEzWM4vLK2C).

    Here are our [playlists](https://www.youtube.com/@RedHatEnterpriseLinux/playlists). You can find various playlists on topics such as product updates and Satellite configuration and administration.

    # Reddit
    Come find us on Reddit at r/redhat.
    https://www.reddit.com/r/redhat/
tabs:
- id: d2teuijqhcov
  title: controlnode
  type: terminal
  hostname: controlnode
- id: yapmn6f1xgcj
  title: vm1
  type: terminal
  hostname: controlnode
  cmd: ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1
- id: 3nmln4oousqe
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3000
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":66,"children":[{"leaf":{"tabs":["d2teuijqhcov","3nmln4oousqe"],"activeTabId":"d2teuijqhcov","size":49}},{"leaf":{"tabs":["yapmn6f1xgcj"],"activeTabId":"yapmn6f1xgcj","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

> _NOTE:_ To make the inline images larger, expand this window. ![Menu Slider](../assets/slider.png)

This lab is composed of two hosts.

1. controlnode
2. vm1

In this lab, we will use the host `controlnode` as the "control node" or the node where we will install and run the firewall system role. Firewall changes will be applied to `vm1`.

We'll perform the following 3 tasks.

1. We will use the firewall system role to open the appropriate port to access web servers on `vm1`. This exercise is to show how to open firewall ports by service.

2. As well, we will also use the firewall system role to open port 9999 on `vm1` to enable inbound tcp connections. This exercise is to show how to open an arbitrary firewall port.

3. Finally, we'll configure port forwarding from 9999 to port 12345 on `vm1`.

![afterapplying](../assets/firewallsystemrolesoverview.png)

You can access each host by clicking on the tabs in the upper left corner of the GUI.

![tabs](../assets/instruqt-tab.png)
