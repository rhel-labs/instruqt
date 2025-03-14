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
- id: cdtsw1xxv3jq
  title: Terminal
  type: terminal
  hostname: rhel
- id: oky0rvpmn0xu
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3000
enhanced_loading: null
---

Click on the tab titled **RHEL Web Console** at the top of  your lab system interface. Selecting this tab will open the lab system's Web Console in a new browser tab or window.

> [!NOTE]
> If you have issues logging into the web console, try using a Private window or a different browser. Using Chrome, you may get a warning that the password is insecure or found in a breach. Since this is a temporary resource, we aren't using a very secure password and this warning can be ignored.

Once the login page is presented, use the following credentials to log into the Web Console:

1 - Username:

```bash
rhel
```

2 - Password:

```bash
redhat
```

![](../assets/Web-console-login.png)

Once logged in, proceed to the next step.