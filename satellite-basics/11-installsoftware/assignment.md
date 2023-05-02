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

We'll install software on multiple hosts simultaneously, using a Host Collection.

A host collection is a group of content hosts. This feature enables you to perform the same action on multiple hosts at once. These actions can include the installation, removal, and update of packages and errata, change of assigned life cycle environment, and change of Content View. You can create host collections to suit your requirements, and those of your company. For example, group hosts in host collections by function, department, or business unit.

For more information on Host Collections, please see [Configuring Host Collections](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.11/html/managing_hosts/configuring_host_collections_managing-hosts).

First we'll create a Host Collection. Click on `Host Collections` in the menu.

<a href="#1">
 <img alt="An example image" src="../assets/hostcollectionsmenubar.png" />
</a>

<a href="#" class="lightbox" id="1">
 <img alt="An example image" src="../assets/hostcollectionsmenubar.png" />
</a>

Click `Create Host Collection`.

<a href="#2">
 <img alt="An example image" src="../assets/createhostcollection.png" />
</a>

<a href="#" class="lightbox" id="2">
 <img alt="An example image" src="../assets/createhostcollection.png" />
</a>

Next, do the following:

1) Name the `Host Collection`. In this case we'll name it `TMUX installation`.
2) Click `Save`.

<a href="#3">
 <img alt="An example image" src="../assets/tmuxinstallationhostcollection.png" />
</a>

<a href="#" class="lightbox" id="3">
 <img alt="An example image" src="../assets/tmuxinstallationhostcollection.png" />
</a>

Click on `Hosts`.

<a href="#4">
 <img alt="An example image" src="../assets/hchosts.png" />
</a>

<a href="#" class="lightbox" id="4">
 <img alt="An example image" src="../assets/hchosts.png" />
</a>

Click on `Add`.

<a href="#5">
 <img alt="An example image" src="../assets/hchostsadd.png" />
</a>

<a href="#" class="lightbox" id="5">
 <img alt="An example image" src="../assets/hchostsadd.png" />
</a>

Select the hosts we want to install `tmux` on, then click `Add Selected`. In this example we will install `tmux` on `rhel1` and `rhel2`.

<a href="#6">
 <img alt="An example image" src="../assets/hcaddrhel9hosts.png" />
</a>

<a href="#" class="lightbox" id="6">
 <img alt="An example image" src="../assets/hcaddrhel9hosts.png" />
</a>

Click on the `Details` tab.

<a href="#7">
 <img alt="An example image" src="../assets/clickontmuxinstallation.png" />
</a>

<a href="#" class="lightbox" id="7">
 <img alt="An example image" src="../assets/clickontmuxinstallation.png" />
</a>

Click on `Package Installation, Removal, and Update`.

<a href="#8">
 <img alt="An example image" src="../assets/packageinstallation.png" />
</a>

<a href="#" class="lightbox" id="8">
 <img alt="An example image" src="../assets/packageinstallation.png" />
</a>

Do the following:

1) Type in the package name. In this case we'll install `tmux`.
2) Click `install`.
3) Click `yes`.

<a href="#9">
 <img alt="An example image" src="../assets/updatepackages.png" />
</a>

<a href="#" class="lightbox" id="9">
 <img alt="An example image" src="../assets/updatepackages.png" />
</a>

You'll be taken to the job status page.

<a href="#10">
 <img alt="An example image" src="../assets/statusinstall.png" />
</a>

<a href="#" class="lightbox" id="10">
 <img alt="An example image" src="../assets/statusinstall.png" />
</a>

You can check on the real-time installation progress by clicking on a host.

<a href="#11">
 <img alt="An example image" src="../assets/installtmuxstatusonhost.png" />
</a>

<a href="#" class="lightbox" id="11">
 <img alt="An example image" src="../assets/installtmuxstatusonhost.png" />
</a>

When the installation has completed, click on the terminal of `rhel1` or `rhel2` and run `tmux`.

```bash
tmux
```

tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal. [tmux documentation is available here](https://github.com/tmux/tmux/wiki).

<a href="#12">
 <img alt="An example image" src="../assets/2022-08-10_09-02-46.gif" />
</a>

<a href="#" class="lightbox" id="12">
 <img alt="An example image" src="../assets/2022-08-10_09-02-46.gif" />
</a>

<style>
.lightbox {
  display: none;
  position: fixed;
  justify-content: center;
  align-items: center;
  z-index: 999;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.8);
}

.lightbox:target {
  display: flex;
}

.lightbox img {
  max-height: 100%;
}
</style>
