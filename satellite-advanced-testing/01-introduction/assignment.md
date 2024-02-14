---
slug: introduction
id: 5xxhkqmvt2fx
type: challenge
title: Familiarize yourself with the Lab Environment.
teaser: This is an introduction to the lab environment.
notes:
- type: text
  contents: Familiarize yourself with the lab environment.
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
timelimit: 3420
---
<!-- markdownlint-disable MD033 -->
The lab environment consists of the following

1) Red Hat Satellite 6.13.x Server (Satellite is preinstalled)
2) Red Hat Enterprise Linux 9 hosts.

<a href="#1">
 <img alt="An example image" src="../assets/satellite-basics-environment.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/satellite-basics-environment.png" />
</a>

## <ins>Log into the Web UI</ins>

First, we'll log into the Red Hat Satellite Web User Interface (UI). Satellite has been preinstalled and installation is out of scope for this lab.

Click on the tab labelled Satellite Web UI as shown in the image below.

<a href="#2">
 <img alt="An example image" src="../assets/satellite-tab.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/satellite-tab.png" />
</a>

A new tab will open in your web browser stating the connection is insecure. This lab has been authored and tested with Google Chrome so please try that it if doesn't load properly.

Ignore the security message about insecure connections by clicking on `Advanced`.

<a href="#3">
 <img alt="An example image" src="../assets/insecure-warning.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/insecure-warning.png" />
</a>

Next click on `Proceed`.

<a href="#4">
 <img alt="An example image" src="../assets/proceed.png" />
</a>

<a href="#" class="lightbox" id="4">
 <img alt="An example image" src="../assets/proceed.png" />
</a>

You'll need the following credentials to log into the Satellite Web UI.

You can copy and paste each of them below.

```bash
admin
```

```bash
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```

Now click `Log In`.

<a href="#5">
 <img alt="An example image" src="../assets/webuilogin.png" />
</a>

<a href="#" class="lightbox" id="5">
 <img alt="An example image" src="../assets/webuilogin.png" />
</a>

You will be taken to the main dashboard.

<a href="#6">
 <img alt="An example image" src="../assets/main-menu.png" />
</a>

<a href="#" class="lightbox" id="6">
 <img alt="An example image" src="../assets/main-menu.png" />
</a>

## <ins>Access the RHEL Hosts</ins>

At the top of the screen, you'll find tabs for the hosts `rhel1` and `rhel2`. Terminal and Web Console access are provided.

<a href="#7">
 <img alt="An example image" src="../assets/hosts-tabs.png" />
</a>

<a href="#" class="lightbox" id="7">
 <img alt="An example image" src="../assets/hosts-tabs.png" />
</a>

The credentials for these hosts are the following:

Username:

```bash
rhel
```

Password:

```bash
redhat
```

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
