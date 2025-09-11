---
slug: patch-templates
id: fxxqz04glyxy
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
- id: xilwymyosypz
  title: Red Hat Hybrid Cloud Console
  type: website
  url: https://console.redhat.com
  new_window: true
- id: xqw22ofehl1f
  title: Terminal
  type: terminal
  hostname: rhel1
  cmd: tmux attach-session -t "term1"
- id: bxvi8cofldot
  title: Notepad
  type: code
  hostname: rhel1
  path: /notes/notepad
difficulty: basic
enhanced_loading: null
---
<!-- markdownlint-disable MD033 MD026-->

We will now patch our system with patches that were published up to December 31 by creating a patch template with a date of December 31, 2022. We'll

Go to the Patch template application.

![patch template app](../assets/patchtemplateapp.png)

Click the `Create a template` button.

![create a template button](../assets/createatemplatebutton.png)

Perform the following tasks in the `Create patch template` menu.

1) Give the template a name. In this example we'll name it `summit-template`.
2) Set the `Patch template date` to `2022-12-31`.
3) Click `Next`.

![patch template new](../assets/newpatchtemplate.png)

In the `Select systems` menu do the following.

1) Select the host you just launched in AWS.
2) Click `Next`.

![select systems](../assets/selectsystems.png)

Click `Submit`.

![submit template](../assets/submitpatchtemplate.png)

Once the template has been created, go back to the System view in the Patch application, and click on your system, based on the private  IP address / hostname.  Note that it reports that it is using the Patch template you created, and that there are no applicable advisories or packages.  This is because the container-tools advisory was published after the date we specified in the Patch template.
