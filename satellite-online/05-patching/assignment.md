---
slug: patching
id: u74cdbblrazc
type: challenge
title: Patching hosts
teaser: Patch hosts through the Red Hat Hybrid Cloud console
notes:
- type: text
  contents: We will create and apply patch templates in order to control the applicable
    advisories to a system. We will also check if there is any applicable errata to
    the system and apply it if necessary.
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
