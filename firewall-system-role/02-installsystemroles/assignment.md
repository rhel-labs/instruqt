---
slug: installsystemroles
id: 3anmcihgppy3
type: challenge
title: Install System Roles
teaser: Install System Roles
notes:
- type: text
  contents: Install the firewall RHEL system role.
tabs:
- id: fawzh4mfupxy
  title: controlnode
  type: terminal
  hostname: controlnode
- id: xjo3jxzqs5od
  title: vm1
  type: terminal
  hostname: controlnode
  cmd: ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1
- id: dl1pzm38ev9g
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":66,"children":[{"leaf":{"tabs":["fawzh4mfupxy","dl1pzm38ev9g"],"activeTabId":"fawzh4mfupxy","size":49}},{"leaf":{"tabs":["xjo3jxzqs5od"],"activeTabId":"xjo3jxzqs5od","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

Now we'll install system roles.

Switch to the [button label="controlnode"](tab-0) terminal by clicking on this button: [button label="controlnode"](tab-0)

![rhel tab](../assets/rhel-tab.png)

Enter the following command.

```bash,run
dnf install rhel-system-roles -y
```
> [!NOTE]
> You can click on the `run` button and select the terminal where you wish to run the command.
> ![](../assets/runbutton.png)

The resulting output will look similar to the output below.

![srinstalled](../assets/srinstalled.png)
