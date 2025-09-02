---
slug: configure-unit-files
id: jxdvchivmtxq
type: challenge
title: Configure the unit files
teaser: Configure the container and volume unit files.
notes:
- type: text
  contents: We will walk through the configuration of systemd unit files to set up
    an Apache web server container. Once the unit files are created, we'll start the
    container service which initiates the automatic download of a specified container
    image, and set up the persistent storage to store the data to serve a web page.
tabs:
- id: wyuexm1ywhke
  title: rhel
  type: terminal
  hostname: rhel
  cmd: su - garfield
- id: brxigixpqh3o
  title: Editor
  type: code
  hostname: rhel
  path: /home/garfield/.config/containers/systemd/
difficulty: basic
timelimit: 0
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":65,"children":[{"leaf":{"tabs":["wyuexm1ywhke"],"activeTabId":"wyuexm1ywhke","size":48}},{"leaf":{"tabs":["brxigixpqh3o"],"activeTabId":"brxigixpqh3o","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---
Now we'll configure the `httpd.container` and `httpd-data.volume` files.

Edit the httpd.container file
===
Switch to the `Editor` tab by clicking this button: [button label="Editor" background="#ee0000" color="#c7c7c7"](tab-1)
In the `Editor` tab, click on `httpd.container`.
![Aug-28-2024_at_13.34.46-image.png](../assets/Aug-28-2024_at_13.34.46-image.png)

Copy and paste the following code blog into the editor. Once pasted, the editor will automatically save the file.
```ini
[Service]
Restart=always

[Container]
ContainerName=httpd
Image=docker.io/library/httpd
Label="io.containers.autoupdate=registry"
Environment=TZ=America/Vancouver
Environment=VERSION=docker
Volume=httpd-data.volume:/usr/local/apache2/htdocs:Z
PublishPort=8080:80/tcp

[Install]
WantedBy=default.target

```
The `[Service]` section specifies that the `httpd.container` service should always be restarted regardless if it was shut down cleanly.

The `[Container]` section specifies the following:
1) `ContainerName` is `httpd`.
2) `Image` defines where to pull the image from. In this case, it is being pulled from the docker.io public registry.
3) `Volume` defines that the directory inside of the container `/usr/local/apache2/htdocs` should be exposed to the host so that the user `garfield` can edit the contents.
4) `PublishPort` defines port 8080 on the host should map to port 80 in the container.

Edit the httpd-data.volume file
===
In the `Editor` tab, click on `httpd-data.volume`.
![Aug-28-2024_at_13.48.33-image.png](../assets/Aug-28-2024_at_13.48.33-image.png)
Copy and paste the following code blog into the editor.
```ini
[Volume]
User=garfield
Group=garfield

```
The `Volume` section specifies that the user `garfield` and members of the group `garfield` have rights to modify the persistent volume that will be created.

Verify configuration files have been created successfully
===
Let's check that the configuration files have been created and saved.
Switch to the `rhel` terminal by clicking this button: [button label="rhel" background="#ee0000" color="#c7c7c7"](tab-0)

Run the following command to find the unit files we just saved.
```bash,run
ls /home/garfield/.config/containers/systemd/
```
![Aug-28-2024_at_14.40.44-image.png](../assets/Aug-28-2024_at_14.40.44-image.png)

Run the following to view the contents of `httpd.container`.
```bash,run
cat /home/garfield/.config/containers/systemd/httpd.container
```

Run the following to view the contents of `httpd-data.volume`.
```bash,run
cat /home/garfield/.config/containers/systemd/httpd-data.volume
```

If you were to create multiple container services, all the unit files will be stored in `/home/garfield/.config/containers/systemd/`.
