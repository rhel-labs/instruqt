---
slug: completing-conversion
id: wewab4rcftii
type: challenge
title: Completing the Conversion
tabs:
- title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
- title: console
  type: terminal
  hostname: host
- title: rhel
  type: terminal
  hostname: host
  cmd: tmux attach-session -t "converted"
- title: host Web Console
  type: external
  url: https://host.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

If you have waited for the conversion to complete from the previous step, you will need to reboot the system in order to put the changes into effect.
=====================================================================================================================================================

```bash
reboot
```
After executing reboot, the session in the `centos` tab will end. Refresh the `centos` tab until you are reconnected.

![refresh](../assets/refreshbutton.png)

With the convert2rhel utility running, the system will now replace the CentOS signed packages with Red Hat signed versions. The system will reboot a few times: first to boot into a temporary environment from which to make these changes, a second time to perform a relabel on SELinux contexts, and a final time in order to boot into the newly created RHEL environment.

If you did not wait for the completion of the previous step, switch to the RHEL tab and jump to section `Verifying the upgrade` to finish the lab. If you waited for the completion of the conversion, please continue in this section.
=======================================================================================================================================================================================================================================

![image.png](../assets/image.png)

In order to see what the server is during during this process, you will need to connect to the virtual machine's console. In the title bar, click on the "console" tab. Use the `virsh` command to connect to your VM's console:

```bash
virsh console centos
```

<pre class='file'>
# virsh console centos
Connected to domain 'centos'
Escape character is ^] (Ctrl + ])
</pre>

Once the conversion has been completed, use `CTRL + ]` to disconnect from the console and log back in using ssh:

```bash
ssh -i ~/.ssh/id_rsa centos
```

Verifying the upgrade
=====================

## If you did not wait for the conversion to complete, please continue this lab in the `rhel` tab. If you waited for the conversion to complete, please continue this lab in the `centos` tab.

Now that you are connected into your new RHEL system, you should verify your results:

```bash
cat /etc/redhat-release
```

<pre class='file'>
# cat /etc/redhat-release
Red Hat Enterprise Linux Server release 7.9 (Maipo)
</pre>

Verify that the necessary Red Hat repositories are enabled. Also, note that none of the old CentOS repos are available:

```bash
yum repolist
```

<pre class='file'>
# yum repolist
Loaded plugins: fastestmirror, product-id, search-disabled-repos, subscription-manager
Loading mirror speeds from cached hostfile
convert2rhel-for-rhel-7-rpms                                                                                                                                                                                               | 3.8 kB  00:00:00
rhel-7-server-rpms                                                                                                                                                                                                         | 3.5 kB  00:00:00
(1/3): convert2rhel-for-rhel-7-rpms/group                                                                                                                                                                                  |  124 B  00:00:00
(2/3): convert2rhel-for-rhel-7-rpms/primary_db                                                                                                                                                                             | 3.9 kB  00:00:00
(3/3): convert2rhel-for-rhel-7-rpms/updateinfo                                                                                                                                                                             | 3.2 kB  00:00:00
repo id                                                                                                           repo name                                                                                                                 status
convert2rhel-for-rhel-7-rpms                                                                                      Convert2RHEL for OS 7                                                                                                          5
rhel-7-server-rpms/7Server/x86_64                                                                                 Red Hat Enterprise Linux 7 Server (RPMs)                                                                                  33,153
repolist: 33,158
</pre>

Now you can review the logs from the conversion itself:

```bash
less /var/log/convert2rhel/convert2rhel.log
```

<pre class='file'>
# less /var/log/convert2rhel/convert2rhel.log

[07/22/2022 17:55:00] TASK - [Prepare: Show Red Hat software EULA] ******************************
The following text is a copy of the November 18, 2019 version of Red Hat GPLv2-Based End User License Agreement (EULA) [1].
For up-to-date version of the EULA, visit [2].
[1] https://www.redhat.com/licenses/Red_Hat_GPLv2-Based_EULA_20191118.pdf
[2] https://www.redhat.com/en/about/agreements

... output truncated ...
</pre>
