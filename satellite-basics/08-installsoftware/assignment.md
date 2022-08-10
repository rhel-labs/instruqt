---
slug: installsoftware
id: g5xp3pfgjbv2
type: challenge
title: Install Software
teaser: Install Software on hosts
notes:
- type: text
  contents: Install Software on hosts
tabs:
- title: Satellite Server
  type: terminal
  hostname: satellite
- title: Satellite Web UI
  type: external
  url: https://satellite.${_SANDBOX_ID}.instruqt.io
- title: rhel1
  type: terminal
  hostname: rhel1
- title: rhel1 Web Console
  type: external
  url: https://rhel1.${_SANDBOX_ID}.instruqt.io:9090
- title: rhel2
  type: terminal
  hostname: rhel2
- title: rhel2 Web Console
  type: external
  url: https://rhel2.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---
<!-- markdownlint-disable MD033 -->

We'll install software on our hosts using a Host Collection.

A host collection is a group of content hosts. This feature enables you to perform the same action on multiple hosts at once. These actions can include the installation, removal, and update of packages and errata, change of assigned life cycle environment, and change of Content View. You can create host collections to suit your requirements, and those of your company. For example, group hosts in host collections by function, department, or business unit.

For more information on Host Collections, please see [Configuring Host Collections](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.11/html/managing_hosts/configuring_host_collections_managing-hosts).

First we'll create a Host Collection. Click on `Host Collections` in the menu.

![host collections menu bar](../assets/hostcollectionsmenubar.png)

Click `Create Host Collection`.

![create host collection](../assets/createhostcollection.png)

Next, do the following:

1) Name the `Host Collection`. In this case we'll name it `TMUX installation`.
2) Click `Save`.

![tmux hc](../assets/tmuxinstallationhostcollection.png)

Click on `Hosts`.

![hosts](../assets/hchosts.png)

Click on `Add`.

![hchostsadd](../assets/hchostsadd.png)

Select the hosts we want to install `tmux` on, then click `Add Selected`.

![add selected](../assets/hcaddrhel9hosts.png)

Go back to the `Host Collections` menu. Click on the host collection we just created.

![click on tmux installation](../assets/clickontmuxinstallation.png)

Click on `Package Installation, Removal, and Update`.

![installation](../assets/packageinstallation.png)

Do the following:

1) Type in the package name. In this case we'll install `tmux`.
2) Click `install`.
3) Click `yes`.

![update packages menu](../assets/updatepackages.png)

You'll be taken to the job status page.

![status](../assets/statusinstall.png)

You can check on the real-time installation progress by clicking on a host.

![installtmuxstatus](../assets/installtmuxstatusonhost.png)

When the installation has completed, click on the terminal of `rhel1` or `rhel2` and run `tmux`.

```bash
tmux
```
tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal. [tmux documentation is available here](https://github.com/tmux/tmux/wiki).

![tmux](../assets/2022-08-10_09-02-46.gif)
