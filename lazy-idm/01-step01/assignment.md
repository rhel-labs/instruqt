---
slug: step01
id: xlpxyvvf9xtm
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:

    Learn about, and deploy practical security goals on Red Hat Enterprise Linux

    <blockquote>
    <p>
    <strong>NOTE:</strong> This lab environment will expire in less than two hours.
    </p>
    </blockquote>
tabs:
- id: kg6uipczyzlr
  title: bastion
  type: terminal
  hostname: bastion
- id: bb130mqqxn8t
  title: IDM Console
  type: browser
  hostname: idmconsole
difficulty: basic
timelimit: 6900
enhanced_loading: null
---
# Step 1 Server install

You need to go to the terminal to the right and cd to conf24, which will be the directory we work out of. It already has the roles you will use for this lab, plus and ansible.cfg file.

[#inventory]
## Inventory

### Hosts Section
```bash
all:
  children:
    ipaserver:
      hosts:
        idmsrv.{{ shortname }}.{{ root_domain }}:
```

### Variable Section
```bash
  vars:
# Global variables
    admin_password: "[[ Instruqt-Var key="SSH_PASSWORD" hostname="bastion" ]]" # Administrator password used for all applications
    root_domain: "example.com" # Root domain (also used as Windows domain)
    shortname: "idm" # Sub-domain
    domain: "{{ shortname }}.{{ root_domain }}" # Full domain name
    third: "0" # Third octect of subnet used.
# IdM variables
    ipaserver_domain: "{{ domain }}"
    ipaserver_realm: "{{ domain | upper }}"
    ipaserver_setup_dns: true
    #ipaserver_setup_adtrust: true
    #ipaserver_reverse_zones: "{{ third }}.168.192.in-addr.arpa"
    ipaserver_allow_zone_overlap: true
    ipaserver_forwarders: 10.64.1.254
    ipaserver_forward_policy: first
    ipaserver_no_dnssec_validation: true
    ipaserver_netbios_name: "{{ shortname | upper }}"
    ipaserver_firewalld_zone: public
    ipaclient_mkhomedir: true
## IdM password variables, do not use same one for Prod/Dev. Same only for demo/POC
    ipaadmin_password: "{{ admin_password }}" # IdM admin password
    ipadm_password: "{{ admin_password }}" # IdM directory manager password
```

[#playbook]
## Server Playbook
```bash
---
# Installs IdM server and enables DNS PTR sync
- name: Installs the IdM server
  hosts: ipaserver
  roles:
    - role: redhat.rhel_idm.ipaserver
  tags: server
#- name: Turn IdM DNS PTR Sync on
#  hosts: ipaserver
#  roles:
#    - role: idm-dns_ptr
#  tags: server
```

[#Browser]
== Accessing the browser
First, open a terminal window and run `{socks_ssh_command}` using the password `{admin_pass}`.

Next, open the `Firefox` browser, and click the 3 horizontal lines on the search bar line, click on `Settings`, type proxy in the `Find in Settings` search bar.

Once the `Network Settings` shows up, click `Settings` and select `Manual proxy configuration`. Add set the `SOCKS Host` to localhost and `Port` to 5060. Finally check the checkbox for `Proxy DNS when using SOCKS v5`.

Lastly, enter in `idmsrv.idm.example.com` in the search bar.