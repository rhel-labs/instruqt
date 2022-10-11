---
slug: step1
id: cof3ptr2xueq
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    # Goal:
    After completing this scenario, users will be able to create customized Red Hat Enterprise Linux images using Image Builder plugin within Web Console.

    # Concepts included in this scenario:
    * Creating a custom blueprint to use for machine image creation
    * Building a custom Red Hat Enterprise Linux machine image
    * Monitoring the image build process

    # Example Usecase:
    Using Image Builder to make system images would be a consistent, repeatable
    way to build the same installed system, but output the image to different
    cloud formats for use in a hybrid cloud environment.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 3420
---
# Software installation and configuration
Prior to getting started with image builder, the software must first be
installed.  By installing the plugin for Web Console, all of the other
required packages will also be installed.

```
yum install cockpit-composer
```

Type `y` to confirm the installation fo the software.

Now that the software is installed, restart the web console so that it picks up
the newly installed plugin for image builder.

```
systemctl restart cockpit
```
