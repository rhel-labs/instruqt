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

> preamble on why we're using host collections

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

You'll be taken back to the `Host Collections` menu. Click on the host collection we just created.

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

![tmux](../assets/2022-08-10_09-02-46.gif)
