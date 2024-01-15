---
slug: intro-and-login
id: jq2zpdgqdfax
type: challenge
title: Logging Into Red Hat Insights
notes:
- type: text
  contents: |
    # Overview

    As an administrator, you commonly need to inquire into where you are using Red Hat Enterprise Linux (RHEL), and if you need to purchase more of it. The Subscriptions Service (aka Swatch) provides a means to look into this usage and make business decisions based upon it.

    ## Concepts included in this scenario:

    * Get an overview of your RHEL Subscription usage
    * Get a filtered view of your RHEL Subscirption usage

    ## Example Usecase:

    * You administer a fleet of RHEL systems, and need to keep your subscriptions within compliance.
tabs:
- title: Red Hat Hybrid Cloud Console
  type: browser
  hostname: console
difficulty: basic
timelimit: 3000
---
>_NOTE:_ To make the inline images larger, expand this window.
![Menu Slider](../assets/slider.png)

Red Hat Insights Subscirptions is a service hosted on the Hybrid Cloud Console, that can be used to keep track of your Red Hat Enterprise Linux subscription usage.

First, let's head over to Red Hat's Hybrid Cloud Console, and login.  You should login with the following login and password:

Login:

```bash
swatch_demo_user
```

Password:

```bash
Redhat1!
```
>_NOTE:_ You must use the ctrl-v (or command-v on Mac) keyboard shortcut in order to paste in the embedded browser tab in this lab

![Red Hat Login screen](../assets/cloud-console-login.png)

![Red Hat Password screen](../assets/cloud-console-login-pass.png)

Once you are logged in, navigate to **Services** at the top, then to **Subscriptions and Spend** in the menu on the left, and then finally select **Subscriptions** under the _Red Hat Enterprise Linux_ heading.

>_NOTE:_ Your view may differ from these examples depending on your web browser window's size.

![Subscriptions Navigation](../assets/swatch-nav.png)


Now, we can get started by clicking the `Next` button at the bottom of this panel.
