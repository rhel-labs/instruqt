---
slug: selinux
id: xoaq0lgwyrxn
type: challenge
title: 'Step 4: SELinux System role'
teaser: Verify the system roles and configurations were applied.
tabs:
- id: p7cn3kkyflmk
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: dyhqan08qwmw
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Background
David the web developer has asked to have his website files be located in his home folder instead of the default apache location.

He says he set the correct permissions, but is getting an error.

To do this we will need to make sure the selinux rules are in place.

Lets check to see the permissions on his directory

```bash,run
ls -lh /home/davidj/public_html
```

Lets see if we can see the working webserver
```bash,run
curl http://localhost:1337
```
Next lets make sure we have the selinux context set on the file.
you can do this in a couple of different ways.

```bash,run
ls -Z /home/davidj/public_html
```
So lets have our SELinux system role set the permissions to allow port 1337 and make sure the right selinux file context is on the files.
We have a playbook we can use.

```bash,run
cat selinux.yml
```
# Ansible Playbook Explanation

## What is an Ansible Playbook?
An Ansible playbook is like a recipe book for a computer. It tells the computer what tasks to do to set up or configure a system.

## What Does This Playbook Do?

### Title and Targets
- **Hosts**: It will run on all the computers (hosts) that Ansible is managing.

### Variables
- **selinux_ports**: This sets up rules for SELinux (a security system) to allow traffic on port 1337 using the TCP protocol.
- **selinux_fcontexts**: This sets up file context rules for SELinux. It says that the directory `/home/davidj/public_html` should have the type `httpd_sys_content_t`.

### Roles
- **rhel-system-roles.selinux**: This role sets up SELinux rules and contexts for Red Hat Enterprise Linux.

## Playbook summary
By changing the types of both the port and our target directory to match the existing types for HTTPd services, SELinux will treat David's website the same as the default Apache installation.


Now lets run it with ansible
```bash,run
ansible-playbook -i hosts selinux.yml
```

Since we have made changes to the http service, we need to do is to restart the http service
```bash,run
systemctl restart httpd
```

Now that ansible has made changes lets see if we can access the site
```bash,run
curl http://localhost:1337
```

Next we can take a look at the permissions
```bash,run
ls -lh /home/davidj/public_html
```

```bash,run
ls -Z /home/davidj/public_html
```

We can now move on to the next section.

