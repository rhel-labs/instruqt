---
slug: introduction
id: n59bhkezlwdf
type: challenge
title: Introduction
notes:
- type: text
  contents: |
    # Overview:

    NetworkManager is a great tool for creating and modifying networks. This lab
    will walk you through creating your own network connection from scratch and
    modifying key parameters to control how that network connection behaves.

    # Goal:

    After completing this scenario, users will be able to configure the IP, hostname,
    and DNS for a connection using `nmcli`.

    # Concepts included in this scenario:
    * Learn NetworkManager (`nmcli`) syntax
    * Configure a new dynamic IP connection using DHCP
    * Update this connection to use static IP address assignment
    * Validate and configure DNS server settings
tabs:
- title: Host 1
  type: terminal
  hostname: host1
- title: rhel Web Console
  type: external
  url: https://host1.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
---
What is NetworkManager?
===

NetworkManager is a great tool for creating and modifying network connections.
The `nmcli` command is how you will be running NetworkManager in this lab. Any changes
made with `nmcli` are persistent configuration file changes. This lab will give you an
overview of some of the most common operations you would run using this tool.

Listing network devices
===

Before you can set up a connection, you have to know what hardware
is available for you to use. To show what network devices this system has with
`nmcli`, run

```bash,run
nmcli device
```

This will show a list of network interfaces available on the system as well as
how they are configured, similar to the following:

<pre class=file>
DEVICE  TYPE      STATE         CONNECTION
enp1s0  ethernet  connected     enp1s0
enp7s0  ethernet  disconnected  --
lo      loopback  unmanaged     --                                          --
</pre>

This output shows that there are three devices: __enp1s0__ and __enp7s0__ (ethernet devices)
as well as __lo__ (the loopback device).

Next, you will make your own connection on this host.
