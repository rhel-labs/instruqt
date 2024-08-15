---
slug: openhttpservice
id: tqwcosk2bidy
type: challenge
title: Enable access to the httpd service
teaser: Enable access to the httpd service
notes:
- type: text
  contents: Open the port to enable external connections to the httpd service on port
    80.
tabs:
- id: aja3vlwfhadg
  title: controlnode
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing"
- id: jjy6ddnfvsfb
  title: rhelvm
  type: terminal
  hostname: controlnode
  cmd: tmux attach-session -t "firewall-testing-rhelvm"
- id: 5tlhuxjaynsa
  title: controlnode Web Console
  type: external
  url: https://controlnode.${_SANDBOX_ID}.instruqt.io:9090
difficulty: basic
timelimit: 1
---

In this challenge, we will enable access to the http port 80 on `rhelvm`.

First, we'll prove to ourselves that port 80 is blocked by the firewall running on `rhelvm`.

Switch to the [button label="rhelvm"](tab-1) terminal by clicking on this button: [button label="rhelvm"](tab-1).

Run the following in [button label="rhelvm"](tab-1).

```bash,run
firewall-cmd --list-all
```

![fwcmdno80](../assets/fwcmdno80.png)

The output above shows that port 80 is not open.

In the `rhelvm` terminal, run `nc -l 80`. This command runs the utility `netcat` and tells it to listen for incoming traffic on port 80.

```bash,run
nc -l 80
```

![nclistening](../assets/nclistening.png)

`netcat` is now listening on port 80 on `rhelvm`.

> [!WARNING]
> Do not exit out of `nc` in this terminal!

Switch back to the [button label="controlnode"](tab-0) terminal.

Enter the command `nc rhelvm 80`. This tells `netcat` to connect to port 80 on `rhelvm`.

```bash,run
nc rhelvm 80
```

![noroute](../assets/no-route.png)

`netcat` cannot connect to `rhelvm` on port 80.

Let's use RHEL systems roles to open up port 80 on `rhelvm`.

First, Ansible requires a host file pointing at the `rhelvm` host. The host file looks like this.

<pre>
all:
  hosts:
    rhelvm:
  vars:
    firewall:
      - service: http
        state: enabled
</pre>

Copy and paste the following into the [button label="controlnode"](tab-0) terminal.

```bash,run
tee -a /root/hosts << EOF
all:
  hosts:
    rhelvm:
  vars:
    firewall:
      - service: http
        state: enabled
EOF
```

Next, we'll create a simple Ansible playbook that tells ansible to apply the RHEL Firewall system role.

<pre>
- name: Configure Firewall
  hosts: all
  roles:
    - redhat.rhel_system_roles.firewall
</pre>

Copy paste and run the following in the CLI.

```bash,run
tee -a /root/firewall.yml <<EOF
- name: Configure Firewall
  hosts: all
  roles:
    - redhat.rhel_system_roles.firewall
EOF
```

Now we'll apply the system role to `rhelvm` by running the following command on [button label="controlnode"](tab-0) .

```bash,run
ansible-playbook -i hosts -b firewall.yml
```

![applysystemrole](../assets/applysystemrole.png)

Run `nc rhelvm 80` in the [button label="controlnode"](tab-0) terminal again.

```bash,run
nc rhelvm 80
```

We'll type something into the terminal and hit enter. You should see it printed out in the [button label="rhelvm"](tab-1) terminal.

![ncresult80](../assets/ncport80.png)

Exit out of `nc` in the [button label="controlnode"](tab-0) terminal by typing `ctrl-c`. This will cause `nc` to exit in [button label="rhelvm"](tab-1).

Finally, we'll use `firewall-cmd` to list the open ports on [button label="rhelvm"](tab-1). Switch to the [button label="rhelvm"](tab-1) terminal and run the following command.

```bash,run
firewall-cmd --list-all
```

![fwcmdlistall80](../assets/fwcmdlistall80.png)
