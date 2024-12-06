---
slug: insights-login
id: armxehykuxil
type: challenge
title: Logging into Red Hat Insights service
tabs:
- id: p6u9slwadlyc
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---

>_NOTE:_ To make the inline images larger, expand this window.
![Menu Slider](../assets/slider.png)

Click the hyperlink or browse to [cloud.redhat.com](https://cloud.redhat.com) to access Red Hat's software as a service web portal.

>_NOTE:_ This will open an additional browser window or tab.

Click the _Log in to the console_ button.

![cloud.redhat.com Login](../assets/cloud.redhat.com-homepage-v2.png)

Login using the credentials below:

Login:

```bash
rhel-df93
```

Password:

```bash
Redhat1!
```

![Red Hat Login screen](../assets/redhat-login-01.png)

![Red Hat Password screen](../assets/redhat-login-02.png)

Once you are logged in using the credentials provided above, navigate to _Red Hat Enterprise Linux_ inside the _Services_ drop-down, under _Platform_.

![cloud.redhat.com Homepage](../assets/rhel-menu.png)
