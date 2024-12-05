---
slug: portforward
id: 4c2imrx1ec5x
type: challenge
title: Configure port forwarding
teaser: Configure port forwarding
notes:
- type: text
  contents: Forward TCP requests to port 9999 to port 12345.
tabs:
- id: 2dhre6usylvv
  title: controlnode
  type: terminal
  hostname: controlnode
- id: nnyy6ah7iqm2
  title: vm1
  type: terminal
  hostname: controlnode
  cmd: ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1
- id: 3kbmycpyr2no
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":66,"children":[{"leaf":{"tabs":["2dhre6usylvv","3kbmycpyr2no"],"activeTabId":"2dhre6usylvv","size":49}},{"leaf":{"tabs":["nnyy6ah7iqm2"],"activeTabId":"nnyy6ah7iqm2","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

In this challenge we'll forward incoming tcp requests to vm1 on port 9999 to 12345.

In the [button label="controlnode"](tab-0) terminal, add the lines `- forward_port: '9999/tcp;12345;'` and
`state: enabled`.

<pre>
all:
  hosts:
    vm1:
  vars:
    firewall:
      - service: http
        state: enabled
      - port: ['9999/tcp']
        state: enabled
      - forward_port: '9999/tcp;12345;'
        state: enabled
</pre>

The following command will add those lines for you.

```bash,run
tee -a /root/hosts << EOF
      - forward_port: '9999/tcp;12345;'
        state: enabled
EOF
```

Now run the playbook in the [button label="controlnode"](tab-0) terminal.

```bash,run
ansible-playbook -i hosts -b firewall.yml
```

In the [button label="vm1"](tab-1) terminal, run `nc`, listening on port 12345.

```bash,run
nc -l 12345
```

In the [button label="controlnode"](tab-0) terminal, run `nc` and then type some stuff.

```bash,run
nc vm1 9999
```

![ncport9999](../assets/portforward.png)

Type `ctrl-c` to exit `nc`.
