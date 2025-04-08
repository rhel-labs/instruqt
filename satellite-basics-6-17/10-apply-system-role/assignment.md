---
slug: apply-system-role
id: hyoxr3tcadzi
type: challenge
title: Apply System Role
teaser: Apply System Role to hosts
notes:
- type: text
  contents: RHEL System Roles is a collection of Ansible roles and modules that provide
    a stable and consistent configuration interface to automate and manage multiple
    releases of Red Hat Enterprise Linux.
tabs:
- id: drz7tfr71qc4
  title: Satellite Server
  type: terminal
  hostname: satellite
- id: 0t94clo9tdkd
  title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- id: 9z7ymzrsgvog
  title: rhel1
  type: terminal
  hostname: rhel1
- id: a2tjh2hf6eye
  title: rhel2
  type: terminal
  hostname: rhel2
difficulty: basic
timelimit: 1
enhanced_loading: null
---
Introduction
===
>[!NOTE]
>Before starting this challenge, make sure that your hosts have finished rebooting from the previous challenge. You can easily check by clicking on the terminal tab to check that you have a working session with each host. ![tabs](../assets/hosttab.png)

Earlier, we configured the our host group to have a system role applied to it. Specifically, port 80/tcp was to be opened. You can find out more about [RHEL System Roles here](https://access.redhat.com/articles/3050101).

Once again, navigate to `All Hosts`.

![all hosts](../assets/allhostsagain.png)

Next we'll do the following.

1. Select both hosts.

2. Click `Select Action`.

3. Select `Run all Ansible roles`.

![apply system roles](../assets/applysystemroles.png)

In the `Overview` menu you'll be shown the status of the jobs.

![system role](../assets/systemrolestatus.png)

If you want, click on a host to view the application of the system role.

![firewall stpes](../assets/firewallsteps.png)

You can verify that port 80/tcp has been opened by doing the following.

Click on one of these buttons for [button label="rhel1" background="#ee0000" color="#c7c7c7"](tab-2) **or** [button label="rhel2" background="#ee0000" color="#c7c7c7"](tab-4).

![host tab](../assets/hosttab.png)

Run the following command.

```bash,run
firewall-cmd --list-all
```

![fwcmd](../assets/firewallcmdoutput.png)
