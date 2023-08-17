---
slug: install-podman
id: iopfgm84wjvu
type: challenge
title: Install Podman
notes:
- type: text
  contents: |
    # Goal: Visualize data with Grafana
    # Overview:

    After completing this scenario, users will be able to configure a Grafana container, connect to a MySQL database, and create a data dashboard.

    # Concepts included in this scenario:

    * Podman
    * SQL
    * Data visualization
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
In this lab, you will install Grafana, a browser-based data visualization tool. You will install Grafana as a container and manage it through Podman.

First, install RHEL Container Tools by running the following command:
```bash
dnf install -y container-tools
```
Container Tools includes Podman along with other applications that make it easier to manage containers on RHEL, and it is available for all RHEL subscriptions, including the free [Developer Subscription for Individuals](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#). To learn more about Podman, check out this helpful [Podman Cheat Sheet](https://developers.redhat.com/cheat-sheets/podman-cheat-sheet).

Using `systemctl`, start Podman and allow it to start every time the system boots:
```bash
systemctl enable --now podman
```