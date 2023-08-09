---
slug: install-podman
type: challenge
title: Install Podman
teaser: A short description of the challenge.
notes:
- type: text
  contents: |
    # Goal: Run containers in RHEL using Podman
    # Overview

    After completing this scenario, users will be able to configure and manage containers from a Dockerfile using both the Podman command line interface and the Cockpit Podman tool in RHEL web console.

    ## Concepts included in this scenario:

    * Podman
    * Networking
    * Cockpit
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  port: 3000
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 600
---
In this lab, you will install Grafana, a browser-based data dashboard, in two ways. First, you will install and run it through the RHEL web console. After that, you will install and configure the Grafana container through Podman's command line interface (CLI).

First, install RHEL Container Tools by running the following command:
```bash
dnf install -y container-tools
```
Container Tools includes Podman along with other applications that make it easier to manage containers on RHEL, and it is available for all RHEL subscriptions, including the free [Developer Subscription for Individuals](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#). To learn more about Podman, check out this helpful [Podman Cheat Sheet](https://developers.redhat.com/cheat-sheets/podman-cheat-sheet).

Start Podman using `systemctl`
```bash
systemctl start podman
```

Using `systemctl`, allow Podman to start every time the system boots:
```bash
systemctl enable podman
```