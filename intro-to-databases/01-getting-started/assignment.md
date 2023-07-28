---
slug: getting-started
id: xoq0aopvftwp
type: challenge
title: 'Step 1: Install MySQL'
notes:
- type: text
  contents: |
    # Goal:

    Depends on you!

    This is an environment without pre-planned lab content intended
    to be a place where you can explore a Red Hat Enterprise Linux system on
    a topic of your choosing.

    <blockquote>
    <p>
    <strong>NOTE:</strong> This lab environment will expire in less than two hours.
    </p>
    </blockquote>
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: website
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
  new_window: true
difficulty: basic
timelimit: 6000
---
First, install MySQL by running the following command:
```bash
sudo dnf install mysql-server
```

Next, start MySQL with this command:
```bash
systemctl start mysqld.service
```

Now use `systemctl` to allow MySQL to automatically start when the system boots:
```bash
systemctl enable mysqld.service
```

Finally, to improve the security of your MySQL installation, run the following command to initiate a secure configuration process:
```bash
mysql_secure_installation
```