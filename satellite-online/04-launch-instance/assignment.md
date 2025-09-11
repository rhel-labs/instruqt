---
slug: launch-instance
id: 9tyv0z8czvc7
type: challenge
title: Launch an instance
teaser: Launch a virtual machine instance based on images created in the image builder
  application.
notes:
- type: text
  contents: Launch a virtual machine in AWS, based on the image created in the image
    builder application.
tabs:
- id: yqglguav3bhm
  title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
- id: n0rkmunmvadv
  title: Terminal
  type: terminal
  hostname: rhel1
  cmd: tmux attach-session -t "term1"
- id: og4c7qdbl1cq
  title: Notepad
  type: code
  hostname: rhel1
  path: /notes/notepad
difficulty: basic
enhanced_loading: null
---
<!-- markdownlint-disable MD033 MD026-->

In the `Image Builder` menu, find the `summit-test` image. Click on `Launch`.

![launch summit test](../assets/launchsummittest.png)

The next menu will prefill several values to customize the VM instance. We'll need to choose the instance type `t2.medium` and click `Next`.

![t2](../assets/t2medium.png)

Select the SSH public key `rhte_public_key` and click `Next`.

![ssh key](../assets/sshkeyselection.png)

Review the details before clicking `Launch`.

![review details launch](../assets/reviewdetailslaunch.png)

When your instance has launched successfully, copy down the ID, DNS, and SSH command. In particular, save the SSH command.

![instance launched](../assets/instancelaunched.png)

**Do not close this window.**

You can save the SSH command in the built in `Notepad`.

Then click on the `Notepad` tab.

![notepad](../assets/notepadtab.png)

Click on `/notes/notepad`.

![notesnotepad](../assets/notesnotepad.png)

Paste the SSH command into the notepad and save it by clicking on the disk icon.

![save](../assets/savesshcommand.png)

Return to the Launch window.

![launched](../assets/instancelaunched.png)

Clicking on the ID hyperlink will take you directly to the AWS console instance information page.

AWS credentials will be provided in-session.

![aws console instance](../assets/awsconsoleinstance.png)

Note that the instance was assigned a **private** DNS name.

![private dns](../assets/privatednsname.png)

In the `Red Hat Hybrid Cloud Console`, navigate to `Inventory`.

![inventory](../assets/inventory2.png)

Notice that the AWS instance appears in the inventory. Recall that we configured the image to automatically register itself with Red Hat with the activation key `rhte`. When we launched the VM instance in AWS, it was automatically registered with this key.

Let's log into the instance via SSH.

Click on the `Terminal` tab.

![terminal tab](../assets/terminaltab.png)

In the terminal, SSH into the newly provisioned AWS instance. You can copy the SSH command from the `Notepad`.

![ssh](../assets/sshinstance.png)

Let's check the software we added during the image build process is in good working order.

Switch to the root user.

```bash
sudo -i
```

Run the following command to check that `ubi-init` installed successfully by adding a base image.

```bash
podman image list
```

![image list](../assets/podmanimagelist.png)

Run the image in podman.

```bash
podman run e8f952a20c33 &
```

Check that the container is running.

```bash
podman container list
```

![run container](../assets/containerrun.png)

We've now demonstrated that we can build an image with the tools needed for developers to create containerized workloads, using custom software repositories. This workflow can be extended for other applications including workloads such as MS SQL or SAP.
