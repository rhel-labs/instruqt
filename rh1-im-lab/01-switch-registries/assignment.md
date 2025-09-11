---
slug: switch-registries
id: vw2grrcq5y44
type: challenge
title: Red Hat One image mode lab
teaser: Explore and control image tracking with bootc
notes:
- type: text
  contents: |+
    # Goal:

    In this lab you will manage a virtual machine that is running in image mode. You'll explore how bootc tracks images, changing host purposes, and rolling back changes.

    In the first exercise, you will explore how `bootc` tracks images and get an imported VM using a new registry.

    Commands should say BASH in the upper right corner of the block when  hovered over and have a clipboard icon to support copying the command. As the Antora UI bash syntax highlighting isn't always clear, you may need to follow along closely to differentiate between commands to run and expected output.

tabs:
- id: kuvcxioktedf
  title: showroom
  type: service
  hostname: rhel
  port: 8500
  new_window: true
- id: q3n9qvieiufx
  title: Terminal
  type: terminal
  hostname: rhel
  workdir: /root/rh-summit-2024-lb1506
- id: 0vubgtzksaqt
  title: Code editor
  type: code
  hostname: rhel
  path: /root/rh-summit-2024-lb1506
- id: x281x66lyacl
  title: SSH Qcow VM
  type: terminal
  hostname: rhel
  cmd: ssh lab-user@qcow
- id: bqsu6iwtypul
  title: SSH ISO VM
  type: terminal
  hostname: rhel
  cmd: ssh lab-user@iso
difficulty: ""
timelimit: 14400
enhanced_loading: null
---

Welcome to this lab experience for Red Hat Enterprise Linux.

The instructions for this lab will launch in a new window from the `showroom` tab. Once those have launched you can hide this pane using the `Hide Instructions` button in the upper right corner.
