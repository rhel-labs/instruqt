---
slug: step4
id: 0ac72zgtxj1t
type: challenge
title: Step 4
notes:
- type: text
  contents: |
    < embedded video>

    With the convert2rhel utility running, the system will now replace the CentOS signed packages with Red Hat signed versions. The system will reboot a few times first to boot into a temporary environment from which to make these changes, a second time to perform a relabel on SELinux contexts, and a final time in order to boot into the newly created RHEL environment.

    # Disclaimer:
    The Convert2RHEL process can take upwards of 15 minutes to run. Instead of waiting for that process to complete, a second server has been running the conversion in the background. This lab will now connect to that second system to complete the conversion process.
tabs:
- title: Terminal
  type: terminal
  hostname: host2
difficulty: basic
timelimit: 600
---

# Verifying the conversion

You will now be logged into the second server. From here, you will be able to evaluate the convert2rhel process. First, verify that the system is running Red Hat Enterprise Linux:

```
cat /etc/redhat-release
```

<pre class='file'>
# cat /etc/redhat-release
Red Hat Enterprise Linux Server release 7.9 (Maipo)
</pre>

Verify that the necessary Red Hat repositories are enabled. Also, note that none of the old CentOS repos are available:

```
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

OPTIONAL: Now you can review the logs from the conversion itself:

```
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