---
slug: switch-registries
id: oxcota2jthao
type: challenge
title: Change bootc tracking details
teaser: Explore and control image tracking with bootc
notes:
- type: text
  contents: |
    # Goal:

    In this lab you will manage a virtual machine that is running in image mode. You'll explore how bootc tracks images, changing host purposes, and rolling back changes.

    In the first exercise, you will explore how `bootc` tracks images and get an imported VM using a new registry.

    As you move through the exercises, there will be blocks marked `bash` with commands to be run in the right side bar. These may also have a `copy` feature to place the command into your buffer for pasting, and a `run` feature which will automatically execute the command. You can use any of these methods to complete the exercises.
tabs:
- id: 2pnkoae5eysy
  title: Terminal
  type: terminal
  hostname: rhel
- id: whmk4doq1uth
  title: VM console
  type: terminal
  hostname: rhel
  cmd: virsh console bootc
difficulty: basic
timelimit: 3000
---

Welcome to this lab experience for Red Hat Enterprise Linux.

The system displayed beside this text is a Red Hat Enterprise Linux 9 system registered with Subscription Manager.

In a previous image mode lab, we created a virtual machine from a bootc image. That VM was imported into this lab to further explore management of bootc hosts. We'll explore how bootc tracks images, changing host purposes, and rolling back changes.

First, we need get our imported VM working with the infrastructure available in this lab.

Attach to the console of the VM running our bootc image
===

Let's attach to the console. Switch to the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-1) tab.

> [!NOTE]
> If the console hasn't connected or there is an error, you can reconnect by clicking Refresh next to the tab name. The prompt will look like this. ![](../assets/terminal_prompt.png)

A user was created when the VM was created, you can use the following credentials to log in.

Username:

```bash,run
core
```

Password:

```bash,run
redhat
```
> [!NOTE]
> Since we are attached to the console and not an SSH session, you may see dmesg output on certain commands. These can be ignored as informational.

Check the image the VM is using
===
Hosts created from bootc images track a particular image in a specific registry, this is how `bootc` knows when an update is available.

The `spec` section of `bootc status` provides the information about the image in use and where `bootc` is looking for it.
```bash,run
sudo bootc status | grep spec: -A 4
```
Since this VM was created in a different lab, the registry that was used doesn't exist any more. Have we broken our VM?

Let's check if `bootc` can reach the host listed.

```bash,run
sudo bootc upgrade --check
```
You will see a timeout error, since that host is no longer available. The hostname for the registry in this lab is [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]].

Switch to a new image
===
Well we can't get updates from that source any more, but we can tell the host to start tracking a new image with `bootc switch`. A new registry with an image that matches the one currently installed is available in this environment.
```bash,run
sudo bootc switch [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc
```

Like a `bootc update`, `bootc switch` will download and prepare the new image to a local deployment location on disk. It will then stage that image to become active at the next boot.

```bash,run
sudo bootc status | grep staged: -A 8
```

If we needed to wait for a maintenance window we could stage changes immediately, then schedule the reboot. Let's go ahead and restart the system now to get our changes.

```bash,run
sudo reboot
```

Once the system has completed rebooting, you can log back in.
Username:

```bash,run
core
```

Password:

```bash,run
redhat
```

Let's check what the `spec` section of `bootc status` now says about where updates are coming from.
```bash,run
sudo bootc status | grep spec: -A 4
```

You can also look at the `booted` section to see this is now the current default.
```bash,run
sudo bootc status | grep booted: -A 8
```

Let's confirm that `bootc` is using our new registry to check for any updates.

```bash,run
sudo bootc upgrade --check
```
Since we just installed this image and haven't made any updates to it, `bootc` won't have any changes to make.

Once a host it running, changing the image in use is very straightforward, and can be useful for a number of reasons beyond changing image locations. Let's explore a little more of what this new `bootc switch` command can do for us in the next few exercises.
