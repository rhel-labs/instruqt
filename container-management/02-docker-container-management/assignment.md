---
slug: docker-container-management
id: uohlyzjr7tw4
type: challenge
title: Docker Container Management
teaser: A short description of the challenge.
notes:
- type: text
  contents: Replace this text with your own text
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: RHEL Web Console
  type: external
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
- title: Grafana (Docker)
  type: service
  hostname: rhel
  port: 3000
difficulty: basic
timelimit: 600
---
First, install Docker by running the following command:
```bash
dnf install -y docker
```

Next, download and start a Podman image for Grafana with this command:
```bash
docker run -d --name=Grafana -p 3500:3500 docker.io/grafana/grafana:latest
```
>Explanation of the command you just ran:
>* `--name=Grafana` specifies the name of your container.
>* `-p 3500:3500` specifies that the container should be available on the range of network ports from 3500-3500. While this can be more than 1 port, in your case, it is only port 3500.
>* `docker.io/grafana/grafana:latest` is the URL of the dockerfile that your container is based on. `Grafana/grafana` is the name of the image and `:latest` indicates that you want the most recent version. This allows Docker to retrieve the correct container.

Finally, click on the `Grafana` tab in the lab environment. You can now explore this website hosted on your machine. If you see a login page, you have configured your container correctly.

For the login, use the following credentials:
>Username: admin
>Password: admin

You may be prompted to change the login credentials. You can press the `skip` button on that dialog box if you wish.

You may now explore Grafana hosted in your own container through Docker.