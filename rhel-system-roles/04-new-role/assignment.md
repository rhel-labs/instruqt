---
slug: new-role
id: 9q5x0fsx4eeo
type: challenge
title: Adding a new role and settings
teaser: Configuring and updating system configurations with System Roles.
notes:
- type: text
  contents: 'Step 4: Configuring and updating system configurations with System Roles.'
tabs:
- id: a5adouar92lh
  title: Shell
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- id: t10wdx2raxdp
  title: client1
  type: terminal
  hostname: client1
difficulty: basic
timelimit: 1
---
In this step, you will be making changes to the playbook. To refresh your memory, take a look at the initial playbook included by the lab.

```bash,run
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

Now, add an additional configuration so that the timesync role can be used by the playbook. Add the listing for the new role to the bottom of the playbook.

```bash,run
echo "    - role: rhel-system-roles.timesync" >> soe.yml
```

Now that the timesync role is configured in the playbook, you can add settings in the variable section to be used by this role. In the command below, sed is used to add the `timesync_ntp_servers` section and hostname and iburst variables to the playbook.

```bash,run
sed -ie 's/tlog_scope_sssd: all/tlog_scope_sssd: all\n    timesync_ntp_servers:\n      - hostname: time-d-b.nist.gov\n        iburst: yes\n      - hostname: 0.rhel.pool.ntp.org\n        iburst: yes/' soe.yml
```

Take a look at the updated playbook.

```bash,run
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
    timesync_ntp_servers:
      - hostname: time-d-b.nist.gov
        iburst: yes
      - hostname: 0.rhel.pool.ntp.org
        iburst: yes
  roles:
    - role: rhel-system-roles.kernel_settings
    - role: rhel-system-roles.tlog
    - role: rhel-system-roles.timesync
</pre>

When the playbook is next run, the system should be configured to use the time-d-b.nist.gov and a timeserver from the pool at ntp.org.

Before running the playbook, verify the current settings being used by the system with `chronyc`.

```bash,run
ssh client1 chronyc sources
```

<pre>
210 Number of sources = 1
MS Name/IP address         Stratum Poll Reach LastRx Last sample
===============================================================================
^* metadata.google.internal      2   6   377    39  +3323ns[+7463ns] +/-  311us
</pre>

Now execute the updated playbook to apply the changes you have added.

```bash,run
ansible-playbook soe.yml -i hosts.ini
```

<pre>
PLAY [localhost, clients] **********************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [localhost]
ok: [client1]

<<< OUTPUT ABRIDGED >>>

PLAY RECAP *************************************************************************************************************************************
client1                    : ok=36   changed=4    unreachable=0    failed=0    skipped=29   rescued=0    ignored=0
localhost                  : ok=36   changed=4    unreachable=0    failed=0    skipped=29   rescued=0    ignored=0
</pre>
From the above snippet of output, you can see that only 4 items were changed once the playbook was executed. These changes should have been the updated time server settings.

You can verify that your system now uses the updated timeserver settings by using `chronyc`.

```bash,run
ssh client1 chronyc sources
```

<pre>
210 Number of sources = 2
MS Name/IP address         Stratum Poll Reach LastRx Last sample
===============================================================================
^- time-d-b.nist.gov             1   6    37    23  +5670us[+5670us] +/-   61ms
^* time.cloudflare.com           3   6    37    25    -12us[ -200us] +/- 8967us
</pre>

As expected, the system is now configured to use time-d-b.nist.gov and a system assigned from the pool at ntp.org.