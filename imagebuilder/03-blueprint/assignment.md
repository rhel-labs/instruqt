---
slug: blueprint
id: 324u43hj4jlx
type: challenge
title: Create a blueprint.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
## Create a blueprint

Image Builder uses blueprints to create system images, however, none exist on this system  yet.

Select the *Create Blueprint* button to start building your first blueprint.

![Select Create Blueprint](../assets/Create-Blueprint.png)

The first step to creating a new blueprint is naming it.  It is recommended that you also include a description so that others using this blueprint know what system image they are building.  For this lab, use __node-app-server__ as the *Name* and __A node.js and NGINX installed web application server__ as the *Description*.

![Name Your Blueprint](../assets/Create-blueprint-dialog.png)

Click `Create`.

![blueprint](../assets/blueprint.png)

Next we'll create an image.
