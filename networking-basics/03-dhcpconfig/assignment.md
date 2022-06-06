---
slug: dhcpconfig
id: nww36z2xnzhh
type: challenge
title: Configure DHCP
notes:
- type: text
  contents: |
    We'll configure a connection with a dynamically assigned IP address.
tabs:
- title: Host 1
  type: terminal
  hostname: host1
difficulty: basic
timelimit: 60
---
## Dynamic IP configuration with DHCP

The command `nmcli con`, short for connection, is an easy way to make persistent configuration changes to any connection on your network. Dynamic IP configuration with DHCP is the most common way to configure a connection, so the first connection you make in this lab will be dynamic.
If you want more information about when to use dynamic vs. static connections, [this article](https://www.redhat.com/sysadmin/static-dynamic-ip-1) provides a great background.

You will configure a dynamic IP connection on **host01**. You will use the
`nmcli con` command with some additional arguments to specify that you want to `add` a connection, assign a connection name, choose a network interface to assign the connection to, and specify the type type of device the interface uses. Below is an example of this command with each of the values explained:

![con add breakdown](../assets/conAddBreakdown.png)

Run the command to configure this dynamic connection on **host1**:

```bash
nmcli con add con-name ethernet1 ifname enp7s0 type ethernet
```

You should see a confirmation message similar to

<pre class=file>
Connection 'ethernet1' (9957b40e-be3a-4291-b466-e591322aba51) successfully added.
</pre>

>_NOTE:_ NetworkManager will act as the DHCP client when adding a connection without a specified address.

The advantage of using `nmcli` is that configuration changes persist.

Let's check that the configuration has changed.

```bash
nmstatectl show enp7s0
```

![nmstatdhcp](../assets/nmstatedhcp.png)

Some situations call for an IP that will not change over time, or a static IP. The next page will walk you through turning this dynamic connection into a static connection.
