---
slug: introduction
id: 10r5zlttjohg
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

1) Red Hat Satellite 6.15.0 Server (Satellite is preinstalled)
2) Red Hat Enterprise Linux 9 hosts.

![](../assets/satellite-basics-environment.png)

Log into the Web UI
===

First, we'll log into the Red Hat Satellite Web User Interface (UI). Satellite has been preinstalled and installation is out of scope for this lab.

Click on the tab labelled Satellite Web UI as shown in the image below.

![](../assets/satellite-tab.png)

A new tab will open in your web browser stating the connection is insecure. This lab has been authored and tested with Google Chrome so please try that it if doesn't load properly.

Ignore the security message about insecure connections by clicking on `Advanced`.

![](../assets/insecure-warning.png)

Next click on `Proceed`.

![](../assets/proceed.png)

You'll need the following credentials to log into the Satellite Web UI.

You can copy and paste each of them below.

```bash
admin
```

```bash
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```

Now click `Log In`.

![](../assets/webuilogin.png)

You will be taken to the main dashboard.

![](../assets/main-menu.png)

Access the RHEL Hosts
===

At the top of the screen, you'll find tabs for the hosts `rhel1` and `rhel2`. Terminal and Web Console access are provided.

![](../assets/hosts-tabs.png)

The credentials for these hosts are the following:

Username:

```bash
rhel
```

Password:

```bash
redhat
```
