---
slug: 02-inspect
id: debcr82qaz3j
type: challenge
title: Inspecting a pre-made example and applying it.
teaser: Inspecting a pre-made example playbook and applying it.
notes:
- type: text
  contents: 'Step 2: Inspecting a pre-made example playbook and applying it.'
tabs:
- title: Shell
  type: terminal
  hostname: rhel
- title: client1
  type: terminal
  hostname: client1
- title: client2
  type: terminal
  hostname: client2
difficulty: basic
timelimit: 600
---
To get started, an already created playbook has been created that uses both the kernel-settings and session recording system roles. You can inspect the contents of this lab provided playbook to get some more information about what it will do on your system.
```
cat soe.yml
```

The output should look like this.
<pre>
---
- hosts: localhost
  vars:
    kernel_settings_sysctl:
      - name: vm.swappiness
        value: 20
      - name: vm.dirty_ratio
        value: 40
      - name: vm.dirty_expire_centisecs
        value: 500
      - name: vm.dirty_writeback_centisecs
        value: 100
      - name: kernel.sem
        value: "250 32000 100 128"
    tlog_scope_sssd: all
  roles:
    - role: rhel-system-roles.kernel_settings
    - role: rhel-system-roles.tlog
</pre>
From the above output, this playbook will only affect `localhost`. Also, at the bottom, you will notice the roles included, `kernel_settings` and `tlog` (session recording) in the playbook. Because these are the only roles included in the playbook, the `vars` section has variables that are used by these roles.

The `vars` under the kernel_settings_sysctl section are the values of parameters to set on the system to change kernel tunables in the /proc/sys directory structure. The tlog_scope_sssd setting will enable session recording for all users on the system.

Before you run the playbook and adjust the settings of the system, verify the current setting for one of the playbook affected values `vm.swappiness`.

```
cat /proc/sys/vm/swappiness
```

The output should be
<pre>
30
</pre>

After you run the playbook, the swappiness value should be updated to be 20.

> <em>NOTE:</em> swappiness is a setting that determines the kernel's preference for using swap space on the system, the value is between 0-100. The smaller the value, the less preference the kernel has for utilizing swap space.

Execute the playbook that includes our updated settings deployed through RHEL System roles.
```
ansible-playbook soe.yml
```

Here's the output.
<pre>
PLAY [localhost] *************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************
ok: [localhost]

<<< OUTPUT ABRIDGED >>>

PLAY RECAP *******************************************************************************************************************************
localhost                  : ok=16   changed=9    unreachable=0    failed=0    skipped=7    rescued=0    ignored=0
</pre>
After a lot of output, you can see from the output at the bottom of the snippet above, how many elements on the system were changed.

You may have noticed that for session recording, the `tlog` system role managed installing the software needed for session recording in addition to executing the configuration parameters included in the playbook.

Let's apply these roles to `client1` and `client2`. We need to create a `hosts.ini` file specifying the hostnames `client1` and `client2`. Both of these hosts will be part of the `clients` group.

```
cat > hosts.ini << EOF
[clients]
client1
client2
EOF
```

```
cat hosts.ini
```
The `hosts.ini` should contain the following.

<pre>
[clients]
client1
client2
</pre>
Edit the `soe.yml` playbook to add the `clients` host group. This tells ansible to apply the system roles in `soe.yml` to `localhost`, `client1`, and `client2`.

```
sed -i '/^- hosts: localhost/ s/$/, clients/' soe.yml
```
Check the soe.yml file.
```
cat soe.yml
```

<pre>
---
- hosts: localhost, clients
  vars:
    kernel_settings_sysctl:
      - name: vm.swappiness
        value: 20
      - name: vm.dirty_ratio
        value: 40
      - name: vm.dirty_expire_centisecs
        value: 500
      - name: vm.dirty_writeback_centisecs
        value: 100
      - name: kernel.sem
        value: "250 32000 100 128"
    tlog_scope_sssd: all
  roles:
    - role: rhel-system-roles.kernel_settings
    - role: rhel-system-roles.tlog
</pre>
Now run the playbook again to apply the system roles to the clients group.
```
ansible-playbook soe.yml -i hosts.ini
```

Check the swappiness kernel parameter has changed on `client1` and `client2`.

```
for i in client1 client2; do echo -n "$i : " ; ssh $i cat /proc/sys/vm/swappiness; done
```

<pre>
root@rhel:~# for i in client1 client2; do ssh $i cat /proc/sys/vm/swappiness; done
client1 : 20
client2 : 20
</pre>