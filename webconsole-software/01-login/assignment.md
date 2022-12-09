---
slug: login
id: akciiqodpbo5
type: challenge
title: Log into the Web Console
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
timelimit: 3000
---

Click on the tab titled **RHEL Web Console** at the top of  your lab system interface. Selecting this tab will open the lab system's Web Console in a
new browser tab or window.

![web console](../assets/pop-out-2.png)

Click `Advanced`

![Connection not private](../assets/connection-not-private.png)

Then click `Proceed to rhel.xxxx.instruqt.io`

![Proceed](../assets/proceed.png)

Once the login page is presented, use the following credentials to log into the Web Console:

1 - Username:

```bash
rhel
```

2 - Password:

```bash
redhat
```

<a href="#login">
 <img alt="An example image" src="../assets/Web-console-login.png" />
</a>

<a href="#" class="lightbox" id="login">
 <img alt="An example image" src="../assets/Web-console-login.png" />
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
