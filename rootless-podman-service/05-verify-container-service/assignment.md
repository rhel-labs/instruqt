---
slug: verify-container-service
id: ndxdhfrqtsoa
type: challenge
title: Verify the container service is working
teaser: Verify that the container service is working.
notes:
- type: text
  contents: In this assignment we'll check that the container service runs properly.
tabs:
- id: cnwbgdnn9qlw
  title: rhel
  type: terminal
  hostname: rhel
  cmd: su - garfield
- id: 0px5a3hqzu86
  title: Editor
  type: code
  hostname: rhel
  path: /home/garfield/.local/share/containers/storage/volumes/systemd-httpd-data/_data/index.html
difficulty: basic
timelimit: 0
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":65,"children":[{"leaf":{"tabs":["cnwbgdnn9qlw"],"activeTabId":"cnwbgdnn9qlw","size":48}},{"leaf":{"tabs":["0px5a3hqzu86"],"activeTabId":"0px5a3hqzu86","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---
We'll check the service is running properly and then modify the index.html through the persistent volume.

Check the service
===
In the [button label="rhel" background="#ee0000" color="#c7c7c7"](tab-0)  terminal, run the following command to check that the httpd container is running.
```bash,run
podman ps
```
![Aug-28-2024_at_14.44.51-image.png](../assets/Aug-28-2024_at_14.44.51-image.png)

Let's check the systemd service is running the container.
```bash,run
systemctl --user status httpd --no-pager
```
![Aug-28-2024_at_14.46.02-image.png](../assets/Aug-28-2024_at_14.46.02-image.png)

You can stop and start the httpd service with the following commands.

To stop the httpd service.
```bash
systemctl --user stop httpd
```

To start the httpd service.
```bash
systemctl --user start httpd
```

Now let's check that the web server actually works.
```bash,run
curl http://localhost:8080
```
![Aug-28-2024_at_14.52.56-image.png](../assets/Aug-28-2024_at_14.52.56-image.png)

Modify index.html
===
Let's modify the index.html of the web server. We do this by editing the index.html file without having to initiate a terminal connection into the container. We can directly modify the index.html file through the persistent volume mapping.

Persistent volumes for all rootless container services are located in `/home/garfield/.local/share/containers/storage/volumes/`.  For our httpd service, recall that we defined the `httpd-data.volume` file. The volume is contained in `systemd-httpd-data/`.
```bash,run
ls -la /home/garfield/.local/share/containers/storage/volumes/systemd-httpd-data/
```
![Aug-28-2024_at_14.57.37-image.png](../assets/Aug-28-2024_at_14.57.37-image.png)

Notice that the `_data` directory is owned by garfield:garfield as we specified in the `httpd-data.volume` unit file.

Switch to the Editor tab by clicking on this button: [button label="Editor" background="#ee0000" color="#c7c7c7"](tab-1)
![Aug-28-2024_at_15.00.21-image.png](../assets/Aug-28-2024_at_15.00.21-image.png)

Change the sentence `It works!` to `I love lasagna.`.
```text
I love lasagna
```

Switch back to the [button label="rhel" background="#ee0000" color="#c7c7c7"](tab-0) terminal.
Run the curl command again.
```bash,run
curl http://localhost:8080
```
![Aug-28-2024_at_15.11.49-image.png](../assets/Aug-28-2024_at_15.11.49-image.png)
