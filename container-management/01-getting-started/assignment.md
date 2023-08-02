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
In this lab, you will install Grafana, a browser-based data dashboard, in two ways. First, you will install and run it through Podman's command line interface (CLI). After that, you will install and configure the Grafana container through the RHEL web console.

First, install RHEL Container Tools by running the following command:
```bash
dnf install -y container-tools
```
Container Tools includes Podman along with other applications that make it easier to manage containers on RHEL, and it is available for all RHEL subscriptions, including the free [Developer Subscription for Individuals](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#).

Start Podman using `systemctl`
```bash
systemctl start podman
```

Using `systemctl`, allow Podman to start every time the system boots:
```bash
systemctl enable podman
```

Next, download and start a Podman image for Grafana with this command:
```bash
podman run -d --name=Grafana -p 3000:3000 docker.io/grafana/grafana:latest
```
>Explanation of the command you just ran:
>* `--name=Grafana` specifies the name of your container.
>* `-p 3000:3000` specifies that the container should connect through the host's port 3000 and the container's port 3000.
>* `docker.io/grafana/grafana:latest` is the URL of the dockerfile that your container is based on. `Grafana/grafana` is the name of the image and `:latest` indicates that you want the most recent version. This allows Podman to retrieve the correct container.

Finally, run this command to view your containers in Podman:
```bash
podman ps
```
The output should look like this, although the Container ID will differ:
<pre class="file">
CONTAINER ID  IMAGE                             COMMAND     CREATED         STATUS         PORTS                   NAMES
35079bc79503  docker.io/grafana/grafana:latest              17 seconds ago  Up 17 seconds  0.0.0.0:3000->3000/tcp  Grafana
</pre>