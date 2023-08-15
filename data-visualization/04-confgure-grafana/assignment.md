---
slug: confgure-grafana
id: fe4bsmtvtyho
type: challenge
title: Confgure Grafana
notes:
- type: text
  contents: Replace this text with your own text
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: Grafana (Podman)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 600
---
In this step, you will visualize the data from your MySQL database.

Switch to the `Grafana (Podman)` tab of the lab environment.

First, return to Grafana's home screen by clicking on the Grafana logo in the upper-left side of the window.
![](../assets/grafana_home_button.png)

Click the menu button in the upper-left of Grafana, and then click `Dashboards`.
![](../assets/grafana_dashboards_select.png)

Next, click `New` then click `New Dashboard`.
![](../assets/new_dashboard.png)

Click on `Add Visualization`
![](../assets/grafana_add_visualization.png)