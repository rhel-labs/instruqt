---
slug: upgrade-check
id: rffpkehnltki
type: challenge
title: Pre-upgrade check
teaser: Run a Pre-upgrade check on your host
notes:
- type: text
  contents: To ensure that your RHEL upgrade runs smoothly, run the Pre-upgrade check
    on your host.
tabs:
- title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
- title: Terminal
  type: terminal
  hostname: rhel1
  cmd: tmux attach-session -t "term1"
- title: Notepad
  type: code
  hostname: rhel1
  path: /notes/notepad
difficulty: basic
---
<!-- markdownlint-disable MD033 MD026-->

The RHEL preupgrade analysis utility analyzes RHEL8 and RHEL7 hosts to provide recommendations to minimize problems when upgrading to RHEL9.

First, we'll provision a RHEL8 host. Then we'll run the `RHEL preupgrade analysis utility` against it.

Launch a vm from the `summit-rhel8` image. Do the following.

1) Navigate to the `Image Builder` application.
2) Click on `Launch`, next to the `summit-rhel8` image.

![launch rhel 8](../assets/rhel8launch.png)

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
Navigate to the `RHEL preupgrade analysis utility` in the `Tasks` menu under `Toolkit`.

![analysis utility](../assets/toolkittasks.png)

Click on `Run task`.

![run task](../assets/runtask.png)

Select the RHEL8 system you just provisioned and click execute.

<!-- ![execute](../assets/executetask.png) -->
![execute](../assets/preupgradeanalysisrhel8.png)

It will take a few minutes for the job to complete.

Go to the `Activity` tab and the last job run to view the analysis.

![completed](../assets/completedanalysis.png)

![analysis](../assets/upgradeissues.png)

This completes all lab activities.
