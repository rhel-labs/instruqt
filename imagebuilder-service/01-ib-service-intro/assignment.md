---
slug: ib-service-intro
id: dtdx1wws0gej
type: challenge
title: Introduction to the Image Builder Service
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to define a Red Hat Enterprise Linux
    blueprint in the Red Hat Image Builder tool hosted on the Hybrid Cloud Console. Users will
    then take the resulting image and customize it for their needs.

    # Concepts included in this scenario:
    * Using the Image Builder service to define a custom image.
    * Using local tools to further customize the resulting image.
    * Testing this image using a local virtual machine.

    # Example use case:
    Your organization has specific requirements for their system builds, and you would like to build
    those requirements into a custom image that you can then deploy to your public cloud provider.
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
