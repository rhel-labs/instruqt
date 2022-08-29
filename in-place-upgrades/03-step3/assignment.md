---
slug: step3
id: xe2s164p1oix
type: challenge
title: Step 3
tabs:
- title: rhel
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1800
---
# Running the upgrade

Now that you have verified the RHEL system meets all the expected conditions, it is time to kick off the upgrade process: (Note: This process will take awhile.)

```
leapp upgrade --target 8.6
```

<pre class=file>
# leapp upgrade --target 8.6
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * scan_files_for_target_userspace
        Scan the source system and identify files that will be copied into the target userspace when it is created.
====> * scanmemory
        Scan Memory of the machine.

... output truncated ...

Complete!
====> * efi_interim_fix
        Adjust EFI boot entry for first reboot
====> * add_upgrade_boot_entry
        Add new boot entry for Leapp provided initramfs.
A reboot is required to continue. Please reboot your system.


Debug output written to /var/log/leapp/leapp-upgrade.log

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

The upgrade has only been _staged_; it has not been completed at this point. A reboot is required for the RHEL 8-based initial RAM disk image (initramfs), upgrades all packages and automatically reboots to the RHEL 8 system.

```
reboot
```

Tip: You can combine these two steps with the --reboot option
`leapp upgrade --target 8.6 --reboot`