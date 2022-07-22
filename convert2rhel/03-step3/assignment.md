---
slug: step3
id: 5loxag2y1kvy
type: challenge
title: Step 3
notes:
- type: text
  contents: |
    With your CentOS Linux system prepared for conversion, you will now run the convert2rhel utility.
tabs:
- title: Terminal
  type: terminal
  hostname: host
difficulty: basic
timelimit: 600
---

# Understanding the Convert2RHEL command

There are several different combinations of arguments that can be used to execute the conversion process. The main factor is registering your new RHEL system with an active subscription. Your choices are:

1) Fully interactive session: answer questions and input username and password as part of the conversion

2) Including your username and password in the convert2rhel command. This is less desireable since your Red Hat customer portal credentials would then be stored in the server's Bash history in plain text.

3) Including your organization ID and Activation Key as part of the command. This is more secure, however, finding your org-id and creating an activation key are outside the scope of this lab.

# Running the Convert2RHEL utility

In order to automate this process as much as possible, you will kick off the conversion using the activation key combination from #3 above: convert2rhel --org <organization_ID> --activationkey <activation_key>

```
convert2rhel --org 12451665 --activationkey Instruqt_system_registration -y
```

Note: This process will take some time!

<pre class='file'>
# convert2rhel --org 12451665 --activationkey Instruqt_system_registration -y

[07/22/2022 18:40:54] TASK - [Prepare: Show Red Hat software EULA] ******************************
The following text is a copy of the November 18, 2019 version of Red Hat GPLv2-Based End User License Agreement (EULA) [1].
For up-to-date version of the EULA, visit [2].
[1] https://www.redhat.com/licenses/Red_Hat_GPLv2-Based_EULA_20191118.pdf
[2] https://www.redhat.com/en/about/agreements

... output truncated ...

[07/22/2022 18:42:43] TASK - [Convert: Final system checks before main conversion] **************
Comparing the loaded kernel modules with the modules available in the following RHEL kernel packages available in the enabled repositories:

... output truncated ...

[07/22/2022 18:48:33] TASK - [Final: Remove temporary folder /var/lib/convert2rhel/] ************
Temporary folder /var/lib/convert2rhel/ removed

Conversion successful!

WARNING - In order to boot the RHEL kernel, restart of the system is needed.

</pre>

Now that the conversion has been staged successfully, you will need to reboot the system in order to put the changes into effect.

```
reboot
```

<pre class='file'>
# reboot


</pre>