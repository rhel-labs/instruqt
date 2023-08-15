---
slug: blueprint
id: 324u43hj4jlx
type: challenge
title: Create a blueprint.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
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

Click `Next`.

![blueprint](../assets/blueprint-next-button.png)

Next we'll customize the blueprint.

Add in the first package, `nodejs`, into the `Available packages` search bar. Once the filter has been applied, you should now see packages with `nodejs` included in their name.

![add nodejs](../assets/nodejs-select.png)

1) Click on `nodejs`.
2) Click the `>` symbol to add it.

Repeat these actions for the `nginx` package and then click `Next`.

![added](../assets/packages-added.png)

Keep clicking the `Next` button until you reach the `Other` tab of the customizations section within the blueprint creation dialog. As you can see, image builder provides the ability to add custom kernel parameters, add users, open firewall ports, and more.

Then, enter a hostname `node-app-server` for the image.

![](../assets/node-app-server-hostname.png)

Next, click `Review`
![](../assets/review-tab-button.png)

Finally, click `Save` to save the blueprint.
![](../assets/blueprint-save.png)