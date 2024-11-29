---
slug: introduction
id: v0g2qpc0nveq
type: challenge
title: Familiarize yourself with the Lab Environment
teaser: This is an introduction to the lab environment.
notes:
- type: text
  contents: Familiarize yourself with the lab environment.
tabs:
- id: qtm4ocyoeyna
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: rp26lpozmkdc
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: tlkzc6pmwypx
  title: rhel1
  type: terminal
  hostname: rhel1
difficulty: basic
timelimit: 0
enhanced_loading: null
---
<!-- markdownlint-disable MD033 -->
The lab environment consists of the following

1. Two Red Hat Satellite Servers (Satellite is preinstalled)
2. One Red Hat Enterprise Linux 9 host
3. One capsule server.


Log into the Web UI
=================================

First, we'll log into the Red Hat Satellite Web User Interface (UI). Satellite has been preinstalled and installation is out of scope for this lab.

Click on the tab labelled Satellite Web UI as shown in the image below.

![sat tab](../assets/satellite-tab.png)

A new tab will open in your web browser stating the connection is insecure. This lab has been authored and tested with Google Chrome so please try that it if doesn't load properly.

Ignore the security message about insecure connections by clicking on `Advanced`.

![insecure](../assets/insecure-warning.png)

Next click on `Proceed`.

![proceed](../assets/proceed.png)

You'll need the following credentials to log into the Satellite Web UI.

You can copy and paste each of them below.

```
admin
```

```
bc31c9a6-9ff0-11ec-9587-00155d1b0702
```

Now click `Log In`.

![login](../assets/webuilogin.png)

You will be taken to the main dashboard.

![main menu](../assets/main-menu.png)
