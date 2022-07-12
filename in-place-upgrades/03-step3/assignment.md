---
slug: step3
id: xe2s164p1oix
type: challenge
title: Step 3
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

Tip: You can combine these two steps with the --reboot option
`leapp upgrade --target 9.0 --reboot`

While your system is rebooting, navigate to the Web Console in the top row of the interface.

TODO

Login with:

username: rhel
password: rhel

From here, navigate to "Virtual Machines" and select the `rhel` virtual machine.

TODO

This will open up the VM management interface. You will notice on the right-hand side, there is a live terminal window. You can expand this and watch the upgrade process live. Once you have a login prompt, continue to the final step.