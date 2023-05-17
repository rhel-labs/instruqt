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
  type: external
  url: https://cloud.redhat.com
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

Once you are logged in, using the credentials provided above, navigate to
_Red Hat Enterprise Linux_ in the left-side navigation menu, and select _Red Hat Insights_ below it.

![cloud.redhat.com Homepage](../assets/cloud-console-RHEL-menu.png)

Now, in the Red Hat Insights menu on the left, click on the _Image Builder_ item.

![Image Builder Menu](../assets/cloud-console-RHEL-ImageBuilder-menu.png)

You should be at a page very similar to this:
![Image Builder Menu](../assets/cloud-console-RHEL-ImageBuilder.png)
