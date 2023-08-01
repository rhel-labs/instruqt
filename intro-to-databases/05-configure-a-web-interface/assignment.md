---
slug: configure-a-web-interface
id: hf89dvztwoa0
type: challenge
title: 'Optional Final Step: Configure a web interface'
teaser: A short description of the challenge.
notes:
- type: text
  contents: Replace this text with your own text
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: website
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
  new_window: true
- title: phpMyAdmin
  type: website
  url: http://rhel.${_SANDBOX_ID}.instruqt.io:3306
  new_window: true
difficulty: basic
timelimit: 600
---
SQL servers are easiest to manage through the terminal, but when you are first getting started, sometimes a GUI can make things less intimidating. In your own SQL server, you can choose to skip the configuration of a GUI, but we'll set up the GUI in our lab.

We will use phpMyAdmin as a browser-based frontend for our database. The first step for installation is to enable [EPEL (Extra Packages for Enterprise Linux)](https://docs.fedoraproject.org/en-US/epel/). EPEL contains many community-supported packages for Red Hat Enterprise Linux.

Enable EPEL by running the following command:
```bash
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

Next, install phpMyAdmin with the following command:
```bash
dnf install -y phpMyAdmin
```

