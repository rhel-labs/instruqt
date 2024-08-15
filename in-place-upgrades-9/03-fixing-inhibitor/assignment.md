---
slug: fixing-inhibitor
id: gzwccqdiusl7
type: challenge
title: Fixing inhibited results
tabs:
- id: e2hybz0yxiox
  title: RHEL
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@rhel08
difficulty: basic
timelimit: 1
---

You saw in the last step how Leapp produced an error in order to prevent a broken upgrade.  In order to fix this issue, you will need to disable this feature in the sshd configuration file:

```bash,run
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
```

There are other risks that were identified. If you are curious what else LEAPP found, take a closer look at the log file mentioned in the previous step:

```bash,run
cat /var/log/leapp/leapp-report.txt
```

Re-run the preupgrade check to verify the change satisfied the result

```bash,run
leapp preupgrade --target 9.4
```

<pre class=file>
# leapp preupgrade --target 9.4
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * transaction_workarounds
        Provides additional RPM transaction tasks based on bundled RPM packages.
====> * sssd_facts_8to9
        Check SSSD configuration for changes in RHEL9 and report them in model.

..... output truncated .....

Debug output written to /var/log/leapp/leapp-preupgrade.log

============================================================
                           REPORT
============================================================

A report has been generated at /var/log/leapp/leapp-report.json
A report has been generated at /var/log/leapp/leapp-report.txt

============================================================
                       END OF REPORT
============================================================

Answerfile has been generated at /var/log/leapp/answerfile
</pre>

Now, you are ready to run the actual upgrade.