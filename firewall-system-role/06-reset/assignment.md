---
slug: reset
id: 0l3ibcq7odko
type: challenge
title: Reset the firewall to default settings
teaser: Reset the firewall to default settings
notes:
- type: text
  contents: Remove all the changes we made to the firewall rules.
tabs:
- id: f3yybsmkw61s
  title: controlnode
  type: terminal
  hostname: controlnode
- id: bxbcchheqmw7
  title: vm1
  type: terminal
  hostname: controlnode
  cmd: ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1
- id: aujpxtpak9ps
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":66,"children":[{"leaf":{"tabs":["f3yybsmkw61s","aujpxtpak9ps"],"activeTabId":"f3yybsmkw61s","size":49}},{"leaf":{"tabs":["bxbcchheqmw7"],"activeTabId":"bxbcchheqmw7","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

The firewall system role can reset all settings to the default configuration found immediately after Red Hat Enterprise Linux is installed.

We'll reset the firewall configuration in the `vm1` host.

First, in the [button label="vm1"](tab-1) terminal, list the current rules.

```bash,run
firewall-cmd --list-all
```

<pre>
[root@vm1 ~]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp1s0
  sources:
  services: cockpit dhcpv6-client http ssh
  ports: 9999/tcp
  protocols:
  forward: yes
  masquerade: no
  forward-ports:
        port=9999:proto=tcp:toport=12345:toaddr=
  source-ports:
  icmp-blocks:
  rich rules:
</pre>

In the [button label="controlnode"](tab-0) terminal, we'll create a new host file called `reset`.

```bash,run
tee -a /root/reset << EOF
all:
  hosts:
    vm1:
  vars:
    firewall:
      - previous: replaced
EOF
```

From the [button label="controlnode"](tab-0) terminal, run the playbook to reset the firewall rules on the `vm1` host.

```bash,run
ansible-playbook -i reset -b firewall.yml
```

![reset output](../assets/resetplaybook.png)

When the playbook as stopped running, switch to the [button label="vm1"](tab-1) terminal and check that the firewall rules have been reset.

```bash,run
firewall-cmd --list-all
```

<pre>
[root@vm1 ~]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp1s0
  sources:
  services: cockpit dhcpv6-client ssh
  ports:
  protocols:
  forward: yes
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
</pre>

If you want to apply the rules we created in the previous steps of this lab, simply run `ansible-playbook -i hosts -b firewall.yml` again.
