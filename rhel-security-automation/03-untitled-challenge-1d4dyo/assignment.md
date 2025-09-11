---
slug: untitled-challenge-1d4dyo
id: h6v6mfzz7xkn
type: challenge
title: 'Step 3: Sudo System role'
teaser: Verify the system roles and configurations were applied.
tabs:
- id: hpyesqp2vfit
  title: Shell
  type: terminal
  hostname: rhel
- id: qjqqt5tpjnxi
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
enhanced_loading: null
---
# Background

In this lab, your manager Scott says there are is a web developer that is starting today.

His name is David J. and he will need a dedicated account, for awith special sudo permissions to start and stop the httpd service and the ability to host the website from his home directory.

David's account "Davidj" has been made, and he has created some of the needed files, but something is not working.

Let's start by switching user from root to 'davidj' and the password "redhat" and test to see what permissions are working.



```bash,run
su - davidj
```

next we want to see what the status of httpd is

```bash,run
sudo systemctl status httpd
```

```bash,run
redhat
```

Now lets see if he has permission to change the status service,
```bash,run
sudo systemctl start httpd
```
```bash,run
redhat
```

So the account doesn;'t currently have the access to spin up and spin down the httpd service.
To help change that we are going to use the new Sudo System-Role.

Now lets close out of the davidj user and go back to our root user.
```bash,run
exit
```
# Ansible Playbook Explanation

Now we will run create the sudo rule to add him to the sudoers to run a couple of commands using the sudo system rules.

```bash,run
cat webdev.yml
```

# Ansible Playbook Explanation

## What is Ansible?
Ansible is like a set of instructions that a computer can follow to do tasks automatically. It's used to manage and configure servers.

## What Does This Playbook Do?

### Hosts: localhost
This means the playbook will run on the same computer where it is executed. Think of it as telling the computer to do something to itself.

### Vars: (Variables)
These are like settings or options that the playbook uses. In this case, it's setting up some rules for a special file called `sudoers`.

### sudo_sudoers_files:
This is a list of files that will be created or modified to give certain users special permissions.

- **path: /etc/sudoers.d/webdev**
  - This is the location where the file will be created.

- **user_specifications:**
  - This part tells Ansible who can do what.

  - **users:**
    - **davidj**
    - **%webdev**
      - These are the users who will get special permissions. `%webdev` means any user who is part of the `webdev` group.

  - **hosts: ALL**
    - This means these permissions apply to all computers.

  - **operators: ALL**
    - This means any command can be run.

  - **commands:**
    - **/usr/bin/systemctl start httpd**
    - **/usr/bin/systemctl stop httpd**
    - **/usr/bin/systemctl status httpd**
      - These are the specific commands that the users can run. They are commands to start, stop, and check the status of a web server called `httpd`.

### Roles:
This is like a pre-made set of instructions that Ansible can use.

- **role: rhel-system-roles.sudo**
  - This role is specifically for managing `sudo` permissions on Red Hat Enterprise Linux (RHEL) systems.

## What Happens When This Playbook Runs?

- The playbook will create a file at `/etc/sudoers.d/webdev`.
- This file will give the user `davidj` and any user in the `webdev` group the ability to run specific commands related to the `httpd` web server on any computer.
- The commands they can run are to start, stop, and check the status of the `httpd` web server.

So, in simple terms, this playbook sets up special permissions for certain users to control a web server on their computer.


Now run the playbook again to apply the system roles to the clients group.

```bash,run
ansible-playbook -i hosts.ini  webdev.yml
```

Lets log back into David's account
```bash,run
su - davidj
```

next we want to see what the status of httpd is


Now lets see if he has permission to change the status service,
```bash,run
sudo systemctl start httpd
```
Use this as davidj's password.
```bash,run
redhat
```
Once we have started the service, lets make sure it's running.

```bash,run
sudo systemctl status httpd
```

Lets head to the next section.
