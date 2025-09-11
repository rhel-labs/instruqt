---
slug: fapolicyd
id: lnjyki7npyea
type: challenge
title: 'Step 6: Fapolicyd System Role'
teaser: Verify the system roles and configurations were applied.
tabs:
- id: exywkjbudlu2
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: xkxxbiavhyc9
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Ansible Playbook Explanation

Now lets look at a basic Fapolicyd playbook, where we want to install and enable the service to run.

```bash,run
cat fapolicyd.yml
```

## Title
The playbook is named "Fapolicyd role invocation." This is just a title to help you understand what the playbook is about.

## Hosts
The playbook is meant to run on all the servers (hosts) that you specify. Think of it like telling a robot to do something on all the computers in a room.

## Variables
These are like settings or instructions that the playbook will use. Here are the variables:

- `fapolicyd_setup_enable_service: true`: This tells the playbook to enable a service called `fapolicyd`.
- `fapolicyd_setup_integrity: sha256`: This sets the method to check the integrity of files to `sha256`, which is a way to make sure files haven't been changed.
- `fapolicyd_setup_trust: rpmdb,file`: This tells the playbook to trust files from the RPM database and regular files.
- `fapolicyd_add_trusted_file`: This is a list of files that the playbook should trust. In this case, it includes `/etc/passwd`, `/etc/fapolicyd/fapolicyd.conf`, and `/etc/krb5.conf`.

## Roles
This is where the playbook tells the robot what to do. In this case, it uses a role called `rhel-system-roles.fapolicyd`. A role is like a set of instructions that the robot knows how to follow. This role is specifically for setting up and managing the `fapolicyd` service.

## Summary
So, in simple terms, this playbook tells the robot to:
- Enable the `fapolicyd` service on all the servers.
- Use `sha256` to check the integrity of files.
- Trust files from the RPM database and regular files.
- Trust the specific files listed.
- Follow the instructions in the `rhel-system-roles.fapolicyd` role to set up `fapolicyd`.

This playbook is like a recipe that tells a robot how to set up and configure a service on multiple computers.

Now lets run it with ansible
```bash,run
ansible-playbook -i hosts.ini fapolicyd.yml
```

Let'd go for the next step.
