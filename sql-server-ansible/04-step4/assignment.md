---
slug: step4
id: febcsr7bt04x
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Run the Ansible Playbook

Now, let's run our ansible playbook defined in the site.yml file and pass it the list of hosts.

```bash
ansible-playbook -i myhosts site.yml
```

> The playbook has several tasks, and some tasks could take a bit longer than usual.

Running the playbook should produce output similar to the following:

<pre class="file">
PLAY [all] ***************************************************************************************

TASK [Gathering Facts] ***************************************************************************
ok: [localhost]

TASK [microsoft.sql.server : Set platform/version specific variables] ****************************
ok: [localhost] => (item=RedHat.yml)
ok: [localhost] => (item=RedHat.yml)
...

RUNNING HANDLER [microsoft.sql.server : Restart the mssql-server service] ************************
changed: [localhost]

PLAY RECAP ***************************************************************************************
localhost                  : ok=34   changed=17   unreachable=0    failed=0    skipped=28   rescued=1    ignored=0
</pre>
