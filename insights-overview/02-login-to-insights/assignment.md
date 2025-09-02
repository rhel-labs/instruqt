---
slug: login-to-insights
id: tnlsrnbomh1z
type: challenge
title: Accessing the Hybrid Cloud Console
tabs:
- id: rbeloxgebrdy
  title: Terminal
  type: terminal
  hostname: rhel
- id: hymqydcw91rz
  title: Red Hat Hybrid Cloud Console
  type: external
  url: https://console.redhat.com
difficulty: basic
timelimit: 1
enhanced_loading: null
---
>_NOTE:_ To make the inline images larger, expand this window.
![Menu Slider](../assets/slider.png)

There is a tab open inside of the lab environment for the Red Hat Hybrid Cloud Console, click on that, and you will be brought to the login page.

>_NOTE:_ This will open an additional browser window or tab. Also note: If your browser already has a session for the Hybrid Cloud Console, you may need to open a new private window or tab in order to complete the following tasks

Login using the credentials below:

Login:

```bash
rhel-df93
```

Password:

```bash
Redhat1!
```

![Red Hat Login screen](../assets/cloud-console-login.png)

![Red Hat Password screen](../assets/cloud-console-login-pass.png)

Once you are logged in, using the credentials provided above, use the _Services_ drop-down menu to navigate to *Services -> Security -> Vulnerability (Under the RHEL heading)

![Hybrid Cloud Console CVEs](../assets/cloud-console-cves-menu.png)

