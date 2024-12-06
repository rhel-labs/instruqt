---
slug: openarbitraryport
id: zfgmcrojfhrz
type: challenge
title: Open an arbitrary port
teaser: Open an arbitrary Port
notes:
- type: text
  contents: Open an arbitrary port.
tabs:
- id: p7soqhzqy88r
  title: controlnode
  type: terminal
  hostname: controlnode
- id: pyl08dgqyhlx
  title: vm1
  type: terminal
  hostname: controlnode
  cmd: ssh -i /root/.ssh/id_rsa -o "StrictHostKeyChecking no" root@vm1
- id: b8hlw7ggzclv
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
lab_config:
  custom_layout: '{"root":{"children":[{"branch":{"size":66,"children":[{"leaf":{"tabs":["p7soqhzqy88r","b8hlw7ggzclv"],"activeTabId":"p7soqhzqy88r","size":49}},{"leaf":{"tabs":["pyl08dgqyhlx"],"activeTabId":"pyl08dgqyhlx","size":49}}]}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":33}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

In this challenge we'll open port 9999 on `vm1`.

In the [button label="controlnode"](tab-0) terminal, add the lines `- port: ['9999/tcp']` and `state: enabled` to the `hosts` file.

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
</pre>

The following command will add those lines for you.

```bash,run
tee -a /root/hosts << EOF
      - port: ['9999/tcp']
        state: enabled
EOF
```

Now run the playbook in the [button label="controlnode"](tab-0) terminal.

```bash,run
ansible-playbook -i hosts -b firewall.yml
```

![applyportopen](../assets/applyportopen.png)

In the [button label="vm1"](tab-1) terminal, run `nc`, listening on port 9999.

```bash,run
nc -l 9999
```

In the [button label="controlnode"](tab-0) terminal, run `nc` and then type some stuff.

```bash,run
nc vm1 9999
```

![ncport9999](../assets/ncport9999.png)

In the image above the phrase was typed: `the quick brown fox jumps over the lazy dogs` followed by the `enter` key.

In the [button label="controlnode"](tab-0) terminal, type `ctrl-c` to exit `nc`.
