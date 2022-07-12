---
slug: step2
id: 31dsb4tpfgsy
type: challenge
title: Step 2
tabs:
- title: rhel
  type: terminal
  hostname: host1
- title: Host Web Console
  type: external
  url: https://host1.${_SANDBOX_ID}.instruqt.io:9090/machines#/vm/console?name=rhelvm&connection=system
difficulty: basic
timelimit: 1800
---
# Running the pre-upgrade assistant and resolving issues

Built into the leapp tool is a utility that collects data about the system, assesses upgradability, and generates a pre-upgrade report. On your lab system, perform the pre-upgrade test: (This process will take a couple minutes.)

```
leapp preupgrade --target 9.0
```

<pre class=file>
# leapp preupgrade --target 9.0
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * scan_sap_hana
        Gathers information related to SAP HANA instances on the system.
====> * repository_mapping
        Produces message containing repository mapping based on provided file.
====> * persistentnetnames
        Get network interface information for physical ethernet interfaces of the original system.
====> * scan_kernel_cmdline
        No documentation has been provided for the scan_kernel_cmdline actor.
====> * udevadm_info
        Produces data exported by the "udevadm info" command.
====> * scan_pkg_manager
        Provides data about package manager (yum/dnf)
====> * sssd_facts_8to9

... output truncated ...

Check completed.
==> Processing phase `Reports`
====> * verify_check_results
        Check all dialogs and notify that user needs to make some choices.
====> * verify_check_results
        Check all generated results messages and notify user about them.

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

Notice how the upgrade was "inhibited" because the preupgrade assistant requires your input on one or more issues before it will safely proceed. The preupgrade tool has generated an answerfile in `/var/log/leapp`. Inside of this file, it has generated a true/false question regarding the use of VDO devices:

```
cat /var/log/leapp/answerfile
```

<pre class=file>
# cat /var/log/leapp/answerfile
[check_vdo]
# Title:              None
# Reason:             Confirmation
# ========================== check_vdo.no_vdo_devices =========================
# Label:              Are there no VDO devices on the system?
# Description:        Enter True if there are no VDO devices on the system and False continue the upgrade. If the system has no VDO devices, then it is safe to continue the upgrade. If there are VDO devices they must all be converted to LVM management before the upgrade can proceed.
# Reason:             Based on installed packages it is possible that VDO devices exist on the system.  All VDO devices must be converted to being managed by LVM before the upgrade occurs. Because the 'vdo' package is not installed, Leapp cannot determine whether any VDO devices exist that have not yet been converted.  If the devices are not converted and the upgrade proceeds the data on unconverted VDO devices will be inaccessible. If you have any doubts you should choose to install the 'vdo' package and re-run the upgrade process to check for unconverted VDO devices. If you are certain that the system has no VDO devices or that all VDO devices have been converted to LVM management you may opt to allow the upgrade to proceed.
# Type:               bool
# Default:            None
# Available choices: True/False
# Unanswered question. Uncomment the following line with your answer
# no_vdo_devices =
</pre>

In this scenario, there are no VDO devices enabled. It is safe to skip this check. To do so, replace the commented line `# no_vdo_devices =` with a true statement.

```
sed -i 's/# no_vdo_devices =/no_vdo_devices = true/g' /var/log/leapp/answerfile
```

OPTIONAL: Re-run the preupgrade check to verify the change satisfied the result

<pre class=file>
# leapp preupgrade --target 9.0
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor

... output truncated ...

Check completed.
====> * target_userspace_crypto_policies
        Set crypto policies inside the target userspace container.
====> * local_repos_inhibit
        Inhibits the upgrade if local repositories were found.
====> * report_set_target_release
        Reports information related to the release set in the subscription-manager after the upgrade.
====> * check_initramfs_tasks
        Inhibit the upgrade if conflicting "initramfs" tasks are detected
==> Processing phase `Reports`
====> * verify_check_results
        Check all dialogs and notify that user needs to make some choices.
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