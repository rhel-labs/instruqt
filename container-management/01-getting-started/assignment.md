---
slug: getting-started
id: wtgula3lfz4q
type: challenge
title: Podman Container Management
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: Grafana (Podman)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 3000
---
In this lab, you will install Grafana, a web-based system performance dashboard in two ways. First, you will install and run it through Podman's command line interface (CLI). After that, you will install and configure the Grafana container through the RHEL web console.

First, install RHEL Container Tools by running the following command:
```bash
dnf install -y container-tools
```
Container Tools includes Podman along with other applications that make it easier to manage containers on RHEL, and it is available for all RHEL subscriptions, including the free [Developer Subscription for Individuals](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#).

Next, download and start a Podman image for Grafana with this command:
```bash
podman run -d --name=Grafana -p 3000:3000 docker.io/grafana/grafana:latest
```
>Explanation of the command you just ran:
>* `--name=Grafana` specifies the name of your container.
>* `-p 3000:3000` specifies that the container should be available on the range of network ports from 3000-3000. While this can be more than 1 port, in your case, it is only port 3000.
>* `docker.io/grafana/grafana:latest` is the URL of the dockerfile that your container is based on. `Grafana/grafana` is the name of the image and `:latest` indicates that you want the most recent version. This allows Podman to retrieve the correct container.

Finally, click on the `Grafana` tab in the lab environment. You can now explore this website hosted on your machine. If you see a login page, you have configured your container correctly.

For the login, use the following credentials:
>* Username: admin
>* Password: admin

You may be prompted to change the login credentials. You can press the `skip` button on that dialog box if you wish.

You may now explore Grafana hosted in your own container through Podman.