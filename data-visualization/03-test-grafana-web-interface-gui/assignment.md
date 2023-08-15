---
slug: test-grafana-web-interface-gui
id: uccbeu1j8r2x
type: challenge
title: Configure a Data Source
notes:
- type: text
  contents: In this step, you will test the container you configured through the RHEL
    web console.
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
Click on the `Grafana` tab in the lab environment. You can now explore this website hosted on your machine. If you see a login page, you have configured your container correctly.

Log in using the default credentials:
>* Username: admin
>* Password: admin

![](../assets/grafanaloginmenu.png)
You may be prompted to change the login credentials. You can press the `skip` button on that dialog box if you wish.
![](../assets/skippassword.png)
You are now ready to configure Grafana for data visualization.

A MySQL database has been configured for you. This SQL Database contains data on the population of Singapore from 1950 to 2022. You will make a time-series visualization of that data within Grafana, showing the change in population over 72 years.

First, connect Grafana to the MySQL database. To get started, click the menu button in the upper-left of Grafana, and then click `Connections`.
![](../assets/grafana_connections_select.png)

Next, click on the `Add new connection` tab, type `mysql` into the search bar, and click on the MySQL button.
![](../assets/grafana_add_connection.png)

Click on `Create a MySQL data source`
![](../assets/grafana_create_data_source.png)

When prompted with a configuration dialog box, use these settings:
![](../assets/grafana_sql_config.png)

Finally, click `Save & test` to finish configuring your connection to MySQL
![](../assets/grafana_save_test.png)

In the next step, you will configure a data dashboard using this MySQL database of Singaporean population data.
