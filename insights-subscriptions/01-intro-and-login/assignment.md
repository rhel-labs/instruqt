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

Image builder is a tool that can be used to build a custom Red Hat Enterprise Linux base image.
This image can then be deployed across your infrastructure, bare metal, virutal, and cloud.  The Image Builder Service is a version of this tool hosted on the Red Hat Hybrid Cloud Console, at https://cloud.redhat.com, and allows you to design an image without requiring you to install or configure anything locally.  You can also push these images to your cloud provider once they are complete, right from Image Builder itself.

First, let's head over to Red Hat's Hybrid Cloud Console, and login.  You should login with the following login and password:

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

Once you are logged in, navigate to the RHEL menu in Red Hat insights.

![rhel menu](../assets/rhinsightsRHEL.png)

Click on `Inventory`, then `Images`.

![inventory images](../assets/inventoryimages.png)

Proceed to the next challenge by clicking the `Next` button.

![next button](../assets/nextbutton.png)
