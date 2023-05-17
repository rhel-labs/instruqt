---
slug: patch-templates
id: fjafxjrdflz2
type: challenge
title: Patch templates
teaser: Patch hosts with patch templates.
notes:
- type: text
  contents: Patch templates enable granular control of patches through dates. This
    gives organizations control over the application of patches so that they can be
    tested with applications to provide assurance that there are no compatibility
    problems.
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

We will now patch our system with patches that were published up to December 31 by creating a patch template with a date of December 31, 2022. We'll

Go to the Patch template application.

![patch template app](../assets/patchtemplateapp.png)

Click the `Create a template` button.

![create a template button](../assets/createatemplatebutton.png)

Perform the following tasks in the `Create content template` menu.

1) Pick the date `2022-12-31`.
2) Click `Next`.

![create content template](../assets/createcontenttemplate.png)
<!--
1) Give the template a name. In this example we'll name it `summit-template`.
2) Set the `Patch template date` to `2022-12-31`.
3) Click `Next`.

![patch template new](../assets/newpatchtemplate.png) -->

<!-- In the `Select systems` menu do the following.

1) Select the host you just launched in AWS.
2) Click `Next`.

![select systems](../assets/selectsystems.png) -->

Do the following in `Details`.

1) Give the template a name.
2) Click `Next`.

![template details](../assets/templatedetails.png)

In the `Systems` menu, do the following.

1) Select the host you provisioned.
2) Click `Next`.

![template systems](../assets/templatesystems.png)

Click `Submit`.

![submit template](../assets/submitpatchtemplate.png)

Once the template has been created, go back to the System view in the Patch application.

![patch systems menu](../assets/patchsystemsmenu.png)

Click on the system you applied the template to.

![system](../assets/templateappliedsystem.png)

You'll find the patch is greyed out and cannot be applied to your system. This is because the podman advisory was published after the date we specified in the Patch template.
