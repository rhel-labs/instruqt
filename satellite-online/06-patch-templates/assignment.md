---
slug: patch-templates
type: challenge
title: Patch templates
teaser: Patch hosts with patch templates.
notes:
- type: text
  contents: Patch templates enable granular control of patches through dates. This gives organizations control over the application of patches so that they can be tested with applications to provide assurance that there are no compatibility problems.
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

Go to the Patch template application.

![patch template app](../assets/patchtemplateapp.png)

Click the `Create a template` button.

![create a template button](../assets/createatemplatebutton.png)


