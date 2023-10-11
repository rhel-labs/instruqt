---
slug: fixing-inhibitor
id: 1jx3d2n3b2fj
type: challenge
title: Fixing inhibited results
tabs:
- title: RHEL
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" rhel@rhel07
difficulty: basic
---

You saw in the last step how Leapp produced an error. In this scenario, PAM modules are not in use. It is therefore safe to skip this check. To do so, replace the commented line `# confirm =` with a true statement.

```bash
sed -i 's/# confirm =/confirm = true/g' /var/log/leapp/answerfile
```

Re-run the preupgrade check to verify the change satisfied the result

```bash
leapp preupgrade --target 8.8

```

<pre class=file>
# leapp preupgrade --target 8.8
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * scanmemory
        Scan Memory of the machine.
====> * tcp_wrappers_config_read
        Parse tcp_wrappers configuration files /etc/hosts.{allow,deny}.
====> * grubdevname
        Get name of block device where GRUB is located
====> * scan_custom_repofile
        Scan the custom /etc/leapp/files/leapp_upgrade_repositories.repo repo file.
====> * scandasd
        In case of s390x architecture, check whether DASD is used.
====> * network_manager_read_config
        Provides data about NetworkManager configuration.
====> * scan_pkg_manager
        Provides data about package manager (yum/dnf)

... output truncated ...

====> * verify_check_results
        Check all generated results messages and notify user about them.

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