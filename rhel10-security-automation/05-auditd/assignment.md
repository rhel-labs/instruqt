---
slug: auditd
id: nr7qy0fc8s4k
type: challenge
title: 'Step 5: Auditd System Role'
teaser: Verify the system roles and configurations were applied.
tabs:
- id: hx2jvlqlxykt
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: a7romyfdo0ez
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Ansible Playbook Explanation

Lets look at the playbook for AIDE.

```bash,run
cat aide.yml
```

## Playbook Overview

This Ansible playbook is named "Example aide role invocation." It is designed to run on a group of computers called. The playbook includes a role called `rhel-system-roles.aide` and sets several variables to control its behavior.

## Tasks

The playbook has one main task:

1. **Include Role**:
   - **Name**: Include role aide
   - **Variables**:
     - `aide_db_fetch_dir: files`: Tells the role to fetch the database files.
     - `aide_install: true`: Tells the role to install the AIDE software.
     - `aide_generate_config: true`: Tells the role to generate a configuration file for AIDE.
     - `aide_init: true`: Tells the role to initialize the AIDE database.
     - `aide_check: false`: Tells the role not to check the integrity of the files.
     - `aide_update: false`: Tells the role not to update the AIDE database.
   - **Module**: `ansible.builtin.include_role`
   - **Role Name**: `rhel-system-roles.aide`

## What Does It Do?

In simple terms, this playbook tells Ansible to go to a group of computers called "targets" and run a set of instructions to install and set up the AIDE software. AIDE is a tool that helps keep track of changes to files on your computer, which can be useful for security and monitoring purposes.

## Lets Run It!

```bash,run
ansible-playbook -i hosts.ini aide.yml
```

Ok now that we have a baseline, we can check to see what the aide log looks like.

```bash,run
sudo cat /var/log/aide/aide.log
```

Now lets install a new program.

```bash,run
sudo yum install -y vim
```

Now lets see what aide tracked
```bash,run
sudo aide --check
```
This will take 45 to 90 seconds to scan.

