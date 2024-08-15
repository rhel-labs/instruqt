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
  cmd: tmux attach-session -t "firewall-testing"
- id: pyl08dgqyhlx
  title: rhelvm
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing-rhelvm"
- id: b8hlw7ggzclv
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

In this challenge we'll open port 9999 on `rhelvm`.

In the [button label="controlnode"](tab-0) terminal, add the lines `- port: ['9999/tcp']` and `state: enabled` to the `hosts` file.

<pre>
all:
  hosts:
    rhelvm:
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

In the [button label="rhelvm"](tab-1) terminal, run `nc`, listening on port 9999.

```bash,run
nc -l 9999
```

In the [button label="controlnode"](tab-0) terminal, run `nc` and then type some stuff.

```bash,run
nc rhelvm 9999
```

![ncport9999](../assets/ncport9999.png)

In the image above the phrase was typed: `the quick brown fox jumps over the lazy dogs` followed by the `enter` key.

In the [button label="controlnode"](tab-0) terminal, type `ctrl-c` to exit `nc`.
