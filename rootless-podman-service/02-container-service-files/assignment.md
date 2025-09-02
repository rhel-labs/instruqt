---
slug: container-service-files
id: tyszkauozwch
type: challenge
title: Create the container service configuration files
teaser: Create the container service configuration files, including the container
  and volume unit files.
notes:
- type: text
  contents: |-
    Podman integrates seamlessly into Linux systems, and supports systemd. Linux commonly uses the systemd init system to manage local services such as web servers, container engines, network daemons, and all of their interdependencies.

    For more information, refer to [this documentation](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html).
tabs:
- id: xjy3ghgj4zw3
  title: rhel
  type: terminal
  hostname: rhel
  cmd: su - garfield; cd /home/garfield
difficulty: basic
timelimit: 0
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":65,"children":[{"leaf":{"tabs":["xjy3ghgj4zw3"],"activeTabId":"xjy3ghgj4zw3","size":48}},{"leaf":{"tabs":["g9vyfwpwvl7p"],"activeTabId":"g9vyfwpwvl7p","size":48}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---
Now we'll create the service configuration files, also known as `systemd unit` files. These files are plain text ini-style files that encode information about the podman container that we want to run as a rootless service.

In other words, we will log into a non-root user account on our RHEL system and configure a service to run a docker container with Podman.

There are many types of Podman systemd unit files, including container, volume, and network (to name a few). The container unit file contains configuration information about how the docker container should by run by Podman, including where to obtain the image, how to map persistent volumes, and what ports to expose for incoming client connections. For more information, please refer to the Podman [documentation here](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html).

Create the configuration directory
===
In the terminal we are logged in as the user `garfield`. `garfield` is not a privileged user.

We'll create a directory in `garfield`'s home directory to store our unit files. The unit files will be stored in `/home/garfield/.config/containers/systemd/`.

Run the command below by clicking on the `run` button.

```bash,run
mkdir -p ~/.config/containers/systemd/
```

Create the unit files
===
We will create two unit files.
1) `httpd.container`
2) `httpd-data.volume`

Run the command below, by clicking on the run button, to create the `httpd.container` file.

```bash,run
touch ~/.config/containers/systemd/httpd.container
```

Run the command below to create the `httpd-data.volume` file.

```bash,run
touch ~/.config/containers/systemd/httpd-data.volume
```

We'll configure these files and discuss their purpose in the next assignment. Click next to proceed.


