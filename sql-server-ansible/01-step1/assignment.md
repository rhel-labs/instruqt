---
slug: step1
id: nr8vjka1uznz
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Goal:
    After completing this scenario, users will be able to use Ansible playbooks
    to install and configure Microsoft SQL Server on Red Hat Enterprise Linux (RHEL).

    # Concepts included in this scenario:
    * Verifying whether ansible is installed on the system
    * Installing the ansible collection for SQL Server
    * Viewing and editing the ansible playbook variables
    * Running the playbook to install and configure Microsoft SQL Server on RHEL 8
    * Login to SQL Server and query a table

    # Example Use case:
    Your IT team requires a uniform and streamlined way to install Microsoft SQL Server
    across multiple RHEL servers. The SQL Server instances must also be setup using a uniform
    configuration, and the installation process must be repeatable when more servers
    come online.
tabs:
- id: pxvle6bpqwbo
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
enhanced_loading: null
---
## Validate the environment

>For this scenario, `ansible-core` has been installed on the system.

RHEL System Roles is a collection of Ansible roles and modules that provide a stable and consistent configuration interface to automate and manage multiple releases of Red Hat Enterprise Linux. In this step of the lab, we will validate if Ansible is available in the environment.

To check if ansible installation is complete, we can use the following command -

```bash
ansible --version
```

You should see the output below -

<pre class="file">
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.6/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.6.8 (default, Jan 11 2019, 02:17:16) [GCC 8.2.1 20180905 (Red Hat 8.2.1-3)]
</pre>

In Ansible, the inventory represents machines that Ansible will manage. In this example, we will create a inventory file called 'myhosts' and add one group called [[sqlgroup]].

```bash
echo "[sqlgroup]" > myhosts
```

Next, add the host to the group.  You can have multiple machines under a group, but for this scenario we will have only one machine (i.e. localhost).

```bash
echo localhost ansible_connection=local >> myhosts
```

Verify that the myhosts file has been created:

```bash
cat myhosts
```

Next, use the ping module to verify that your inventory is working properly:

```bash
ansible all -i myhosts -m ping
```

The response should look be:

<pre class="file">
localhost | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
</pre>

So, now that we have confirmed Ansible is properly configured, let's look at Ansible Playbooks.
