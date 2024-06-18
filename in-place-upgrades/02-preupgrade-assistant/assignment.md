---
slug: preupgrade-assistant
id: jtppuyrfsxln
type: challenge
title: Running the Pre-upgrade Assistant
tabs:
- title: RHEL
  type: terminal
  hostname: host
  cmd: ssh -o "StrictHostKeyChecking no" root@rhel07
difficulty: basic
---
Running the pre-upgrade assistant and resolving issues
===

Built into the leapp tool is a utility that collects data about the system, assesses upgradability, and generates a pre-upgrade report. On your lab system, perform the pre-upgrade test: (This process will take a couple minutes.)

```bash,run
leapp preupgrade --target 8.10
```

<pre class=file>
# leapp preupgrade --target 8.10
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * network_manager_read_config
        Provides data about NetworkManager configuration.
====> * storage_scanner
        Provides data about storage settings.
====> * sssd_facts
        Check SSSD configuration for changes in RHEL8 and report them in model.
====> * persistentnetnames
        Get network interface information for physical ethernet interfaces of the original system.
====> * scan_pkg_manager
        Provides data about package manager (yum/dnf)

... output truncated ...

============================================================
                     UPGRADE INHIBITED
============================================================
Upgrade has been inhibited due to the following problems:
    1. Inhibitor: Missing required answers in the answer file
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

Notice how the upgrade was "inhibited" because the preupgrade assistant requires your input on one or more issues before it will safely proceed. The preupgrade tool has generated an answerfile in `/var/log/leapp`. Inside of this file, it has generated a true/false question regarding PAM PKCS11 modules:

```bash,run
cat /var/log/leapp/answerfile
```

<pre class=file>
# cat /var/log/leapp/answerfile
[remove_pam_pkcs11_module_check]
# Title:              None
# Reason:             Confirmation
# =================== remove_pam_pkcs11_module_check.confirm ==================
# Label:              Disable pam_pkcs11 module in PAM configuration? If no, the upgrade process will be interrupted.
# Description:        PAM module pam_pkcs11 is no longer available in RHEL-8 since it was replaced by SSSD.
# Reason:             Leaving this module in PAM configuration may lock out the system.
# Type:               bool
# Default:            None
# Available choices: True/False
# Unanswered question. Uncomment the following line with your answer
# confirm =
</pre>