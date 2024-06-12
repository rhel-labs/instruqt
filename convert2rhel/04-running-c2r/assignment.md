---
slug: running-c2r
id: gnrrq9g1gpdx
type: challenge
title: Running Convert2RHEL
tabs:
- title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
difficulty: basic
timelimit: 1
---

## Running the conversion

Now that you have fixed the inhibitor, it is time to convert your system to RHEL.

> [!NOTE]
> Pro Tip: You can further automate the conversion process by adding a `-y` to the end of the command. This will auto-accept the EULA and prompts your conversion offers.

```bash,run
convert2rhel --org 12451665 --activationkey convert2rhel -y

```

<pre class='file'>

... output truncated ...

[07/22/2022 18:42:43] TASK - [Convert: Final system checks before main conversion] **************
Comparing the loaded kernel modules with the modules available in the following RHEL kernel packages available in the enabled repositories:

... output truncated ...

[07/22/2022 18:48:33] TASK - [Final: Remove temporary folder /var/lib/convert2rhel/] ************
Temporary folder /var/lib/convert2rhel/ removed

Conversion successful!

WARNING - In order to boot the RHEL kernel, restart of the system is needed.

</pre>

The conversion can take about 15 minutes to complete.
