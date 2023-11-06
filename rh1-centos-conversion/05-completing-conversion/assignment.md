---
slug: completing-conversion
id: ugevjujziuxv
type: challenge
title: Completing the Conversion
tabs:
- title: centos
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@centos
difficulty: basic
---

You will need to reboot the system in order to put the changes into effect.
===========================================================================

```bash
reboot
```
After executing reboot, the session in the `centos` tab will end. Refresh the `centos` tab until you are reconnected.

![refresh](../assets/refreshbutton.png)

With the convert2rhel utility running, the system will now replace the CentOS signed packages with Red Hat signed versions. The system will reboot a few times: first to boot into a temporary environment from which to make these changes, a second time to perform a relabel on SELinux contexts, and a final time in order to boot into the newly created RHEL environment.

Verifying the upgrade
=====================

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
[root@centos ~]# yum repolist
Loaded plugins: fastestmirror, product-id, search-disabled-repos, subscription-manager
Loading mirror speeds from cached hostfile
repo id                                                            repo name                                                                  status
convert2rhel-for-rhel-7-rpms                                       Convert2RHEL for OS 7                                                          10
rhel-7-server-rpms/7Server/x86_64                                  Red Hat Enterprise Linux 7 Server (RPMs)                                   33,833
repolist: 33,843
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
