---
slug: step1
id: akciiqodpbo5
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    # Goal:
    After completing this scenario, users will be able to apply system updates to Red Hat Enterprise Linux 9 systems.

    # Concepts included in this scenario:
    * Authenticating to the **Web Console**
    * Inspect available updates using the **Software Updates** application
    * Apply software updates using the **Software Updates** application

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 900
---
## Log in to the Web Console

Click on the tab titled **RHEL Web Console** at the top of  your lab system interface. Selecting this tab will open the lab system's Web Console in a
new browser tab or window.

![web console](../assets/pop-out-2.png)

Click `Advanced`

![Connection not private](../assets/connection-not-private.png)

Then click `Proceed to rhel.xxxx.instruqt.io`

![Proceed](../assets/proceed.png)

Once the login page is presented, use the following credentials to log into the Web Console:

Username: **rhel**\
Password: **redhat**

![Web Console Login](../assets/Web-console-login.png)
