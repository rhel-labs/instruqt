---
slug: step4
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1800
---
# Running the upgrade

Now that you have verified the RHEL system meets all the expected conditions, it is time to kick off the upgrade process:

```
leapp upgrade --target 9.0
```

Note: This process will take awhile.

<pre class=file>
# leapp upgrade --target 9.0
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * storage_scanner
        Provides data about storage settings.

... output truncated ...

Downloading Packages:
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Complete!
====> * add_upgrade_boot_entry
        Add new boot entry for Leapp provided initramfs.
A reboot is required to continue. Please reboot your system.


Debug output written to /var/log/leapp/leapp-upgrade.log

... output truncated ...

</pre>

The upgrade has only been _staged_; it has not been completed at this point. A reboot is required for the RHEL 9-based initial RAM disk image (initramfs), upgrades all packages and automatically reboots to the RHEL 9 system. 

```
reboot
```