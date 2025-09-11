---
slug: selinux
id: h73foorirqv3
type: challenge
title: 'Step 4: SELinux System role'
teaser: Verify the system roles and configurations were applied.
tabs:
- id: yvz6mdjv2zid
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: synv9wnwe74x
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
- **Name**: The playbook is named "Example Basic Security Automation (BSA) system roles."
- **Hosts**: It will run on all the computers (hosts) that Ansible is managing.

### Variables
- **sudo_rules**: This tells the computer which users can run certain commands without needing a password. In this case, the user "audit-sa" can run the command `/usr/sbin/aide` without a password.
- **selinux_ports**: This sets up rules for SELinux (a security system) to allow traffic on port 1337 using the TCP protocol.
- **selinux_fcontexts**: This sets up file context rules for SELinux. It says that the directory `/home/davidj/public_html` should have the type `httpd_sys_content_t`.
- **aide_db_fetch_dir**: This tells where to fetch the AIDE (Advanced Intrusion Detection Environment) database from.
- **aide_install, aide_generate_config, aide_init, aide_check, aide_update**: These are settings for AIDE. It tells the computer to install AIDE, generate its configuration, initialize it, but not to check or update it.
- **fapolicyd_setup_enable_service, fapolicyd_setup_integrity, fapolicyd_setup_trust, fapolicyd_add_trusted_file**: These are settings for `fapolicyd`, a file access policy daemon. It tells the computer to enable the service, use SHA256 for integrity checks, trust certain files, and add specific files to the trusted list.

### Roles
- **rhel-system-roles.sudo**: This role sets up sudo rules.
- **rhel-system-roles.selinux**: This role sets up SELinux rules.
- **rhel-system-roles.aide**: This role sets up AIDE for file integrity checking.
- **rhel-system-roles.fapolicyd**: This role sets up `fapolicyd` for file access policies.

## What Does It All Mean?

- **Security**: This playbook is all about making the computer more secure.
- **Permissions**: It sets up who can do what without needing a password.
- **File Access**: It controls which files can be accessed and how.
- **File Integrity**: It checks if files have been changed unexpectedly.
- **Network Security**: It controls which network ports can be used.

In simple terms, this playbook is like a set of instructions to make a computer more secure by controlling who can do what, which files can be accessed, and which network ports can be used. It uses different tools and settings to achieve this.

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

