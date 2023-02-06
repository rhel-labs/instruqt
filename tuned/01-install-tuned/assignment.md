---
slug: install-tuned
id: qvxupc8t14hz
type: challenge
title: Install and enable TuneD
teaser: Install and enable TuneD.
notes:
- type: text
  contents: |-
    You have been tasked as a systems administrator to deploy a new RHEL 8 server and tune it for running Microsoft SQL Server.
    In this lab you will get some hands-on experience setting up TuneD to assist you with the tuning portion of this task and you will create a custom TuneD profile to optimize it for your use case.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
---

TuneD is a service that monitors your system and optimizes the performance under certain workloads

TuneD is distributed with a number of predefined profiles, which we will review a little later in this exercise

Let's make sure we have the `tuned` package installed. 

Copy and paste the command below into __> Shell__.

```bash
dnf list tuned
```

Here's what the result should look similar to:

<pre>

root@rhel:~# dnf list tuned
Updating Subscription Management repositories.
Last metadata expiration check: 0:02:56 ago on Mon 06 Feb 2023 08:35:50 PM UTC.
Installed Packages
tuned.noarch                                                              2.19.0-1.el9                                                               @rhel-9-for-x86_64-baseos-rpms
root@rhel:~#

</pre>

We can see that `tuned` is listed under Installed Packages.  Let's make sure it is enabled:

Copy and paste the command below into __> Shell__.

```bash
systemctl status tuned
```

Your output should look similiar to:

<pre>

root@rhel:~# systemctl status tuned
● tuned.service - Dynamic System Tuning Daemon
     Loaded: loaded (/usr/lib/systemd/system/tuned.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2023-02-06 20:37:34 UTC; 3min 4s ago
       Docs: man:tuned(8)
             man:tuned.conf(5)
             man:tuned-adm(8)
   Main PID: 2137 (tuned)
      Tasks: 4 (limit: 23567)
     Memory: 13.2M
        CPU: 285ms
     CGroup: /system.slice/tuned.service
             └─2137 /usr/bin/python3 -Es /usr/sbin/tuned -l -P

Feb 06 20:37:33 rhel systemd[1]: Starting Dynamic System Tuning Daemon...
Feb 06 20:37:34 rhel systemd[1]: Started Dynamic System Tuning Daemon.
root@rhel:~#

</pre>

From the output above we can determine that it is active (running) and that it is enabled so it will start at boot-up time

Lets move on to the next step