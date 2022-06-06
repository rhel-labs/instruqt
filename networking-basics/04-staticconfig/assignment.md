---
slug: staticconfig
id: cgsl0ribjreq
type: challenge
title: Configure a static IP
notes:
- type: text
  contents: |
    Configure a static IP address.
tabs:
- title: Host 1
  type: terminal
  hostname: host1
difficulty: basic
timelimit: 200
---
## Static IP configuration

Now that you have an existing connection, here is how to modify it to use a static IP. Static IP connections are useful in cases where you want to ensure the IP address will not change over time. DHCP clients can reconfigure what IP addresses are being used by hosts under their control, which could interfere with network operations where the address is expected not to change.

NetworkManager has an option that can be used with the `nmcli con` command
to change properties of an existing connection, `nmcli con modify`.
The first step in converting your dynamic connection to a static connection is to specify an IP for the connection to use. Assign the existing connection the IP `192.168.122.110` using the `modify` option:

```bash
nmcli con modify ethernet1 ipv4.addresses 192.168.122.110
```

>_NOTE:_ Modifying the ipv4 address field without specifying a subnet mask (also called a prefix) will default to `/32`, or only a single IP address. If you wish
to add a different subnet mask, for example `/24`, append it to the IP address in the `nmcli con modify` command.

```bash
nmcli con modify ethernet1 ipv4.method manual
```

This removes the DHCP protocol from the configuration file but leaves the, other connection properties unchanged.

Besides the IP and subnet mask, you will typically have a gateway address for your connection as well. The same `nmcli con modify` command can be used to configure the gateway:

```bash
nmcli con modify ethernet1 ipv4.gateway 192.168.122.1
```

>_NOTE:_ You can combine multiple modifications into a single command by appending each additional property you want to change. For example, this command would accomplish all of the changes from this page in one line:

```bash
nmcli con modify ethernet1 ipv4.addresses 192.168.122.110 ipv4.gateway 192.168.122.1 ipv4.method manual
```

You now have a bare-bones connection with a static IP, so the next step will walk you through activating and testing it.
