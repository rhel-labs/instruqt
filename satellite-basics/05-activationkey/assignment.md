---
slug: activationkey
id: 3c8ppplwtvmk
type: challenge
title: Create an Activation Key
teaser: Create an Activation Key
notes:
- type: text
  contents: Create an Activation Key
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

Activation keys provide a method to automate system registration and subscription attachment. You can create multiple keys and associate them with different environments and Content Views. For example, you might create a basic activation key with a subscription for Red Hat Enterprise Linux workstations and associate it with Content Views from a particular environment.

You can use activation keys during content host registration to improve the speed, simplicity and consistency of the process. Note that activation keys are used only when hosts are registered. If changes are made to an activation key, it is applicable only to hosts that are registered with the amended activation key in the future. The changes are not made to existing hosts.

To create an activation key, navigate to the `Activation Keys` menu.

![akmenu](../assets/akmenu.png)

Click on `Create Activation Key`.

![createak](../assets/createak.png)

We'll name this activation key `RHEL9`, select the `Test` environment, select the `RHEL9` content view and then click `save`.

> __NOTE__: The name of the activation key will be used in the next step of this lab to add hosts. The names must match or the hosts will not be registered.

![akcreation](../assets/akcreation.png)
