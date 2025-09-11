---
slug: bsa-playbook
id: y6zzppb55a8j
type: challenge
title: 'Step 7: Putting It All Together'
teaser: Merging all the system roles together to create a Basic Security Automation
  playbook
tabs:
- id: 3cxss1vwagrh
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: ypvz2lzthjvt
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 1
enhanced_loading: null
---
# Ansible Playbook Explanation

## Lets put all the separate roles together
Once you have your settings pushed with ansible, and you want to put them all into one playbook, it would look something like this!

```bash,run
cat bsa.yml
```

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

This playbook is like a recipe that tells a robot how to set up and configure a service on multiple computers.


## Lets Run It!

```bash,run
ansible-playbook -i hosts.ini bsa.yml
```

## Resources

If you want to learn more about RHEL System Roles, you can check out our documentation.
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/automating_system_administration_by_using_rhel_system_roles/intro-to-rhel-system-roles_automating-system-administration-by-using-rhel-system-roles
