---
slug: create-audit
id: dxxtlpejrxgo
type: challenge
title: 'Step 2: Create new audit group and users using ansible system role'
teaser: Create new audit group and users using ansible system role
tabs:
- id: azrkksd28qkl
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: c1p0ewmsonmx
  title: client1
  type: terminal
  hostname: client1
difficulty: ""
timelimit: 1
enhanced_loading: null
---
## Background

In this lab, your manager Scott says there are is a new auditor that is coming in to check the systems for compliance.

His name is John P. and he will need a dedicated account, for auditing purposes.

Today we wil use Ansible to automate the tasks we want to acomplish.

Ansible comes as part of your RHEL subscription, so lets learn to utilize the tool!

## What is Ansible?

Ansible is a tool used to automate tasks on computers. Imagine you have a bunch of computers, and you want to make sure they all have the same software installed, or you want to create new user accounts on all of them. Instead of doing each task manually on every computer, you can use Ansible to do it all at once.

## What is an Ansible Playbook?
An Ansible playbook is like a recipe that tells a computer what to do. It's used to automate tasks, like setting up a new user or installing software.

We will be using a pre-written ansible playbook to add a new group and user.

```bash,run
cat  add-audit-user.yml
```

### What Does This Playbook Do?
This playbook is designed to create a group called "auditteam" and add a user named "johnp" to that group. It also sets a temporary password for the user.

### Step-by-Step Explanation

1. **Header Information**:
   - `name`: This is the name of the playbook. It's like giving your recipe a title.
   - `hosts: all`: This means the playbook will run on all the computers (hosts) it is told to manage.
   - `gather_facts: yes`: This tells Ansible to collect information about the computers it's managing.
   - `become: true`: This means the playbook will run with special permissions, like an admin.

2. **Variables**:
   - `group_name`: This is the name of the group we want to create, which is "auditteam".
   - `tmp_password`: This is a temporary password for the user. It's a bit complicated because it's encrypted.
   - `service_accounts`: This is a list of users we want to add to the group. In this case, there's only one user, "johnp".

3. **Tasks**:
   - This task creates a group named "auditteam". The `state: present` part means it will make sure the group exists.
   - This task adds the user "johnp" to the "auditteam" group.
   - `name: "{{ item.name }}"`: This means the name of the user will be taken from the `service_accounts` list.
   - `groups: "{{ group_name }}"`: This adds the user to the "auditteam" group.
   - `append: true`: This means if the user is already in other groups, they will stay in those groups too.
   - `password: "{{ tmp_password }}"`: This sets the temporary password for the user.
   - `with_items: "{{ service_accounts }}"`: This loops through the list of users in `service_accounts` and applies the task to each one.

### Playbook Summary
This playbook creates a group called "auditteam" and adds a user named "johnp" to that group with a temporary password. It's like setting up a team and giving one person access to that team with a special password.

## Ansible Inventory File

There is another componet of running the anisble automation that we need to look at called the inventory file.

An Ansible inventory file is like a list of all the computers (or hosts) that you want to manage with Ansible. It tells Ansible which servers to connect to and how to group them. This is important because you often want to run the same tasks on multiple computers, and the inventory file helps you organize and manage those computers efficiently.

Lets take a look at this one.

```bash,run
cat  hosts.ini
```
### What is an Ansible Inventory File?

An Ansible inventory file is like a list of computers that you want to manage with Ansible. It tells Ansible which computers to connect to and how to connect to them.

### What Does this Line Mean?

The line you provided is:

```ini
localhost  ansible_connection=local
```

Let's break it down:

1. **localhost**:
   - This is the name of the computer. `localhost` is a special name that means "this computer." So, it's telling Ansible to manage the computer it's running on.

2. **ansible_connection=local**:
   - This part tells Ansible how to connect to the computer. `local` means that Ansible should run the tasks directly on the same computer where Ansible is running, without using a network connection.

### Why Use This Line?

This line is useful when you want to test your Ansible playbooks on your own computer before running them on other computers. It's like practicing your recipe on your own kitchen before cooking for a big party.

By using this inventory file, you can test your Ansible playbooks on your own computer before running them on other computers. This helps you make sure everything works correctly before you use it on a bigger scale.

Now run the playbook to apply the system roles to the localhost.

```bash,run
ansible-playbook -i hosts.ini add-audit-user.yml
```

### Expanding your Automation

Edit the `bsa.yml` playbook to add the `clients` host group.
This tells ansible to apply the system roles in `bsa.yml` to `localhost` and `client1`.
```bash,run
cat > hosts.ini << EOF
localhost  ansible_connection=local
[clients]
client1
EOF
```

The `hosts.ini` should contain the following.

<pre>
localhost  ansible_connection=local
[clients]
client1
</pre>

Now run the playbook to apply the system roles to the clients group.

```bash,run
ansible-playbook -i hosts.ini add-audit-user.yml
```

Awesome, now that we have run the playbook on all the machines, lets move to the next step.

