---
slug: fix-inhibitors
id: uu4vbbizsgds
type: challenge
title: Fix conversion inhibitors
teaser: Fix the conversion inhibitors in your host.
tabs:
- id: 7mc7u9vjznxz
  title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
- id: hq9dklh21pex
  title: Red Hat Insights
  type: browser
  hostname: insights
difficulty: basic
enhanced_loading: null
---
Fix the inhibitors
==================

This CentOS host has a very basic configuration and is easily remediated with an update. Go back into the `centos` tab to access the terminal.

Update the host and reboot. Rebooting is required to load the updated kernel.

```bash,run
yum update -y && reboot
```

![update and reboot](../assets/updatedandreboot.png)

The terminal will lose connection with the centos host leaving the message `exited`.

![exited](../assets/exited.png)

Reconnect to the session in the `centos` tab. Refresh the `centos` tab until you are reconnected.

![refresh](../assets/refreshbutton.png)

You may now proceed to the next challenge or you may perform the optional step below to re-run the pre-conversion.

Optional: rerun the the pre-conversion task to check that the conversion can proceed
====================================================================================

Once reconnected go back into the virtual browser. Click on `Run task again`.

![run task again](../assets/runtaskagain.png)

A new task will be created.
![new task](../assets/newtask.png)

When it completes, the report will tell you that the system is ready for conversion.

![proceed](../assets/proceedconversion.png)
