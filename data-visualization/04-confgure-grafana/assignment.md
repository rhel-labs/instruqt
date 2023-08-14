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
In this step, you will configure Grafana for data visualization.

Switch to the `Grafana (Podman)` tab of your lab environment.

A MySQL database has been configured for you. This SQL Database contains data on the population of Singapore from 1950 to 2022. You will make a time-series visualization of that data within Grafana, showing the change in population over 72 years.

First, connect Grafana to the MySQL database. To get started, click the menu button in the upper-left of Grafana, and then click `Connections`.
![](../assets/grafana_connections_select.png)

Next, click on the `Add new connection` tab, type `mysql` into the search bar, and click on the MySQL button.
![](../assets/grafana_add_connection.png)
