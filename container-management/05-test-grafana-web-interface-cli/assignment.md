---
slug: test-grafana-web-interface-cli
id: jcvvxvxwu8rp
type: challenge
title: Test Grafana Web Interface
notes:
- type: text
  contents: In this step, you will test the container you just configured through
    the Podman command line interface (CLI).
tabs:
- id: wvkqpuzbhst1
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: gwep3diqzser
  title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- id: nwo754dptida
  title: Grafana (Podman)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 600
enhanced_loading: null
---
Click on the `Grafana` tab in the lab environment. You can now explore this website hosted on your machine. If you see a login page, you have configured your container correctly.

Log in using the default credentials:
>* Username: admin
>* Password: admin

![](../assets/grafanaloginmenu.png)
You may be prompted to change the login credentials. You can press the `skip` button on that dialog box if you wish.
![](../assets/skippassword.png)
You may now explore Grafana hosted in your container through Podman.