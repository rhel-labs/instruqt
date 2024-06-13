---
slug: preupgrade-assistant
id: zvp1wrx4pwue
type: challenge
title: Running the Pre-upgrade Assistant
tabs:
- title: RHEL
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@rhel08
difficulty: basic
timelimit: 1
---
Running the pre-upgrade assistant and resolving issues
===

Built into the leapp tool is a utility that collects data about the system, assesses upgradability, and generates a pre-upgrade report. On your lab system, perform the pre-upgrade test: (This process will take a couple minutes.)

```bash,run
leapp preupgrade --target 9.4
```

<pre class=file>
# leapp preupgrade --target 9.4
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * scan_grub_device_name
        Find the name of the block device where GRUB is located
====> * system_facts
        Provides data about many facts from system.

... output truncated ...

============================================================
                     UPGRADE INHIBITED
============================================================
Upgrade has been inhibited due to the following problems:
    1. Inhibitor: Possible problems with remote login using root account
Consult the pre-upgrade report for details and possible remediation.
============================================================
                     UPGRADE INHIBITED
============================================================
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

Notice how the upgrade was "inhibited" because the preupgrade assistant requires your input on one or more issues before it will safely proceed. Take a look at the first entry in the `leapp-report` file in the log directory:

```bash,run
head -n 5 /var/log/leapp/leapp-report.txt
```

<pre class=file>
# head -n 5 /var/log/leapp/leapp-report.txt
Risk Factor: high (inhibitor)
Title: Possible problems with remote login using root account
Summary: OpenSSH configuration file will get updated to RHEL9 version, no longer allowing root login with password. It is a good practice to use non-root administrative user and non-password authentications, but if you rely on the remote root login, this change can lock you out of this system.
Remediation: [hint] If you depend on remote root logins using passwords, consider setting up a different user for remote administration or adding a comment into the sshd_config next to the "PermitRootLogin yes" directive to prevent rpm replacing it during the upgrade.
Key: 3d21e8cc9e1c09dc60429de7716165787e99515f
</pre>

One of the major security changes in RHEL 9 was that the `root` account is no longer allowed to login via SSH by default.