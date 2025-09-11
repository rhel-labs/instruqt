---
slug: upgrade-check
id: yfo2ctxntwj3
type: challenge
title: Pre-upgrade check
teaser: Run a Pre-upgrade check on your host
notes:
- type: text
  contents: To ensure that your RHEL upgrade runs smoothly, run the Pre-upgrade check
    on your host.
tabs:
- id: itjlz2durrhi
  title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
- id: zyxkxk8p6ycx
  title: Terminal
  type: terminal
  hostname: rhel1
  cmd: tmux attach-session -t "term1"
- id: vvfqgt63gjs4
  title: Notepad
  type: code
  hostname: rhel1
  path: /notes/notepad
difficulty: basic
enhanced_loading: null
---
<!-- markdownlint-disable MD033 MD026-->

The RHEL preupgrade analysis utility analyzes RHEL8 and RHEL7 hosts to provide recommendations to minimize problems when upgrading to RHEL9.

Navigate to the `RHEL preupgrade analysis utility` in the `Tasks` menu under `Toolkit`.

![analysis utility](../assets/toolkittasks.png)

Click on `Run task`.

Select a RHEL8 system and click execute.

![execute](../assets/executetask.png)

It will take a few minutes for the job to complete.

Go to the `activites` tab and the last job run to view the analysis.

![analysis](../assets/upgradeissues.png)

This completes all lab activities.
