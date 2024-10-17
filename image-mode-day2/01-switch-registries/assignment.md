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

In a previous image mode lab, we created a virtual machine from a bootc image. Adapting to changes in infrastructure or role is core to how bootc hosts operate. We'll explore how `bootc` tracks images, changes host purposes, and rolls back changes.

Changing registries for our bootc image
===

In the normal course of operations, available infrastructure is often changed or decommissioned in favor of newer options. In our environment, the registry server we've been using has been swapped out for a new server. There's native tooling in `bootc` that let's us change the image that a particular host is using. Unfortunately, this host was missed during that migration and we need to get it back on track.

Attach to the console of the VM running our bootc image
===

Let's attach to the console. Switch to the [button label="VM console" background="#ee0000" color="#c7c7c7"](tab-1) tab.

> [!NOTE]
> If the console hasn't connected or there is an error, you can reconnect by clicking Refresh next to the tab name. The prompt will look like this. ![](../assets/terminal_prompt.png)

You can use the following credentials to log in.

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
Hosts created from bootc images track a particular image in a specific registry, this is how `bootc` knows when an update is available.  Let's check what happens when `bootc` tries to look for an update.

```bash,run
sudo bootc upgrade --check
```

You will see a `no such host` error, since our decommissioned registry name is part of the path for the image.

The spec section of bootc status provides the information about the image in use and where bootc is looking for it.
bash

```bash,run
sudo bootc status | grep spec: -A 4
```
In the output you can see the hostname (and port if needed) as well as the image name. You will also notice the `transport` line, which confirms that we are getting updates for this image from a registry.

Switch to a new image
===
The hostname for our new central registry is [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]].
We can migrate this host to our new registry with `bootc switch`. Note that we haven't changed the repository name or tag, just the registry hostname.
```bash,run
sudo bootc switch [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc
```

At first glance, `bootc switch` doesn't look very different from `bootc upgrade`. It will download and prepare the new image to a local deployment location on disk. You'll notice that since this image has a different SHA from our original image, so it will pull all of the layers even though the images are identical. 

We can confirm that this image has been pulled from our new registry by checking the staged section of `bootc status` and looking at the image path.

```bash,run
sudo bootc status | grep staged: -A 8
```

If we needed to wait for a maintenance window we could stage changes immediately, then schedule the reboot. Let's restart the system now to get our changes.

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

Since update tracking is one of the key features that needs up to date and correct locations, let's confirm that `bootc` is using our new registry to check for any updates.

```bash,run
sudo bootc upgrade --check
```
We haven't made any updates so `bootc` won't detect any changes, but we've confirmed we're using the new registry.

You can also check what the current `spec` section of `bootc status` now says about where updates are coming from.
```bash,run
sudo bootc status | grep spec: -A 4
```

Once a host it running, changing the image in use is very straightforward, and can be useful for a number of reasons beyond changing image locations. Let's explore a little more of what this new `bootc switch` command can do for us in the next few exercises.