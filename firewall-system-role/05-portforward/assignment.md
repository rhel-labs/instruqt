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
- title: controlnode
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing"
- title: rhelvm
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing-rhelvm"
- title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

In this challenge we'll forward incoming tcp requests to rhelvm on port 9999 to 12345.

In the [button label="controlnode"](tab-0) terminal, add the lines `- forward_port: '9999/tcp;12345;'` and
`state: enabled`.

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

In the [button label="rhelvm"](tab-1) terminal, run `nc`, listening on port 12345.

```bash,run
nc -l 12345
```

In the [button label="controlnode"](tab-0) terminal, run `nc` and then type some stuff.

```bash,run
nc rhelvm 9999
```

![ncport9999](../assets/portforward.png)

Type `ctrl-c` to exit `nc`.
