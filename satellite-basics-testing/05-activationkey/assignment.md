---
slug: activationkey
id: kxqalp9lcshs
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

<a href="#1">
 <img alt="An example image" src="../assets/akmenu.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/akmenu.png" />
</a>

Click on `Create Activation Key`.

<a href="#2">
 <img alt="An example image" src="../assets/createak.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/createak.png" />
</a>

We'll name this activation key (1) `RHEL9`, select the (2) `Test` environment, select the (3) `RHEL9` content view and then click (4) `save`.

> __NOTE__: The name of the activation key will be used in the next step of this lab to add hosts. The names must match or the hosts will not be registered.

<a href="#3">
 <img alt="An example image" src="../assets/akcreation.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/akcreation.png" />
</a>

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
