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

    In this lab you will manage a virtual machine running in image mode. You'll explore how bootc tracks images, changes host purposes, and rolls back changes.

    In the first exercise, you will explore how `bootc` tracks images and get an imported VM using a new registry.

    As you move through the exercises, there will be blocks marked `bash` with commands to be run in the right side bar. These may also have a `copy` feature to place the command into your buffer for pasting, and a `run` feature which will automatically execute the command. You can use any of these methods to complete the exercises.
tabs:
- id: 2pnkoae5eysy
  title: Terminal
  type: terminal
  hostname: rhel
- id: whmk4doq1uth
  title: VM SSH session
  type: terminal
  hostname: rhel
  cmd: ssh core@bootc2
difficulty: basic
timelimit: 3000
enhanced_loading: null
---

Welcome to this lab experience for Red Hat Enterprise Linux.

The system displayed beside this text is a Red Hat Enterprise Linux 9 system registered with Subscription Manager.

In a [previous image mode lab](https://www.redhat.com/en/introduction-to-image-mode-for-red-hat-enterprise-linux-interactive-lab), we created a virtual machine from a bootc image. Adapting to changes in infrastructure or role is core to how bootc hosts operate. We'll explore how `bootc` tracks images, changes host purposes, and rolls back changes.

Changing registries for our bootc image
===

In the normal course of operations, available infrastructure is often changed or decommissioned in favor of newer options. One of those newer options is a more recent version of RHEL. Typically, exploring the impact of a new version of RHEL on existing workloads means deploying a whole new set of servers and applications, migrating test data, and more. Finding available resources and time is challenging.

Image mode can make testing these sorts of changes much easier, not only by simplifying the initial creation of an existing deployment on a newer OS, but also by repurposing existing machines with live data for testing. The image based nature also makes A/B testing and roll backs a snap.

Update the Containerfile to RHEL 10
===

Let's do something radical to explore changing the starting bootc image. In the previous lab, we were using RHEL 9. While we could just use a later minor version, let's see what happens if we use the RHEL 10 bootc base instead.  

Click on the [button label="Containerfile" background="#ee0000" color="#c7c7c7"](tab-1) tab.

If not already shown, select Containerfile in the list on the right side of the tab.

![](../assets/containerfile_scripteditor1.png)

Replace the FROM line with the RHEL 10 bootc base image from the catalog
````
FROM registry.redhat.io/rhel10/rhel-bootc:10.0
````

The editor will automatically save changes. Once you see Changes Saved in the upper right, you can return to the [button label="Terminal" background="#ee0000" color="#c7c7c7"](tab-0) tab. You can also use 'Ctrl s' or 'Cmd s' to save depending on your OS.

Use podman to build the image
===
With our changes in the Containerfile saved, we will run `podman build` to get a new image. This time we'll add the tag `el10` so we know which version we're using. We'll talk more about tags in a later exercise, but image names and tags are part of how `bootc` knows what image to track for updates.

```bash,run
podman build -t [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:el10 .
```

It's really that simple to build a new image based on a completely different version of RHEL. Keep in mind that we aren't upgrading in the same sense that `leapp` does. We've built a new thing from a new starting point. We need to account for any changes between RHEL 9 and RHEL 10 in the definitions and configurations. For example, if we'd been using the web console metrics, the functionality of the `cockpit-pcp` package from RHEL 9 was rolled into the RHEL 10 `cockpit-bridge` package. This means we would have caught that change at build time since `dnf` would have thrown an error trying to install the RHEL 9 package. These sorts of changes can be caught early in the cycle.

Once we push the new image to the registry, we can use it immediately on any available image mode host.
```bash,run
podman push [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:el10
```

Connect to the VM running our bootc image
===

Let's connect to the virtual machine via SSH. Switch to the [button label="VM SSH session" background="#ee0000" color="#c7c7c7"](tab-1) tab.

> [!NOTE]
> If the SSH session hasn't connected or there is an error, you can reconnect by clicking Refresh next to the tab name. The prompt will look like this. ![](../assets/terminal_prompt.png)

You can use the following credentials to log in.

Password:

```bash,run
redhat
```

Check the image the VM is using
===
Hosts created from bootc images track a particular image in a specific registry. This is how `bootc` knows when an update is available.  The `bootc status` command provides the information about the image in use and where `bootc` is looking for it.

```bash,run
sudo bootc status 
```

In the output you can see the hostname (and port if needed) as well as the image name for the currently booted image. You will also see an image version that provides build time information about the base image. 

Switch to a new image
===
We can migrate this host to our new RHEL 10 image with `bootc switch`.
```bash,run
sudo bootc switch [[ Instruqt-Var key="CONTAINER_REGISTRY_ENDPOINT" hostname="rhel" ]]/test-bootc:el10
```

At first glance, `bootc switch` doesn't look very different from `bootc upgrade`. It will download and prepare the new image to a local deployment location on disk. It downloads any layers it detects are different based on the metadata available in the registry.

We can see in the output of `bootc switch` that our new image has been queued to be activated the next time the host boots. We can also see if there are any changes waiting by checking `bootc status`. Check the version information under the currently staged image to verify it's RHEL 10.

```bash,run
sudo bootc status
```
>[NOTE]
> You may see SELinux errors during the switch that refer to Non-ASCII characters in a binary policy, these are harmless and we're looking at fixes now.

If we needed to wait for a maintenance window we could stage the changes, then schedule the reboot. Let's restart the system now to get our changes.

```bash,run
sudo reboot
```

Once the system has completed rebooting, you can log back in by clicking the refresh button.

Password:

```bash,run
redhat
```

You will be greeted with a new default MOTD, and notice your original user and password still work. Local changes to the VM persist even though we've completely changed the system software to RHEL 10. You can check the `redhat-release` file to confirm the VM is running RHEL 10. Feel free to explore in other ways to confirm this is really RHEL 10.

```bash,run
cat /etc/redhat-release
```

You will also see the previous RHEL 9 image is still on disk as a roll back option. We'll discuss this in more detail in a later exercise, but this means if we run into any issues during testing we can quickly switch back to the previous RHEL 9 deployment to check behavior, missing packages, or other troubleshooting.  This makes for a simple A/B process to understand new major or minor releases in your own environments and applications. 
```bash,run
sudo bootc status
```

Once a host it running, changing the image in use is very straightforward, and can be useful for a number of reasons beyond radical changes like major versions. We'll stick with RHEL 10 from here, but let's explore a little more of what `bootc switch` can do for us in the next few exercises.
