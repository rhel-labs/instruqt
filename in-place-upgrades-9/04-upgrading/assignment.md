---
slug: upgrading
id: jpf3l5dgonih
type: challenge
title: Running the Upgrade
tabs:
- id: 5fqpqelmm5ok
  title: Serial Port
  type: terminal
  hostname: host
  cmd: virsh console rhel08
difficulty: basic
timelimit: 1
lab_config:
  custom_layout: '{"root":{"children":[{"leaf":{"tabs":["t70ednspl4ez","5fqpqelmm5ok"],"activeTabId":"5fqpqelmm5ok","size":66}},{"leaf":{"tabs":["assignment"],"activeTabId":"assignment","size":32}}],"orientation":"Horizontal"}}'
enhanced_loading: null
---

Log into the serial port console
===

This challenge will be run from the `Serial Port` tab which is a serial port console.

Hit enter on your keyboard to bring up the login prompt.

Login as the user `rhel`.

```bash,run
rhel
```

Enter the password `redhat`.

```bash,run
redhat
```

Change to the super user account.

```bash,run
sudo -i
```

Run the upgrade
===

Now that you have verified the RHEL system meets all the expected conditions, it is time to kick off the upgrade process:
(Note: This process will take awhile.)

```bash,run
leapp upgrade --target 9.5 --reboot
```

<pre class=file>
# leapp upgrade --target 9.5
==> Processing phase `configuration_phase`
====> * ipu_workflow_config
        IPU workflow config actor
==> Processing phase `FactsCollection`
====> * scanblacklistca
        Scan the file system for distrusted CA's in the blacklist directory.
====> * sssd_facts_8to9
        Check SSSD configuration for changes in RHEL9 and report them in model.
====> * nis_scanner
        Collect information about the NIS packages configuration.
====> * scan_target_os_image
        Scans the provided target OS ISO image to use as a content source for the IPU, if any.

... output truncated ...

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

Leapp is performing several actions inside a temporary environment. This includes creating a new initramfs image, relabeling SELinux contexts, and well as cleaning up any remaining RHEL 8 packages. Included is a reboot process that can take up to 15 minutes.

Verify the upgrade
===
Once the new initramfs image is in place, package updates run, and SELinux relabel completion, the system will perform one final reboot.

Once that is done, you must log into the system's terminal.

Log in with this username.
```bash,run
rhel
```

Enter this password.
```bash,run
redhat
```

Finally, we will verify the update was successful by looking at the release file we referenced earlier in the lab:

Run the following command in the `RHEL` terminal.

```bash,run
cat /etc/redhat-release
```

Note that we are now running the latest version of RHEL 9!

<pre class=file>
# cat /etc/redhat-release
Red Hat Enterprise Linux release 9.5 (Plow)
</pre>

OPTIONAL: You may also review the log file if you so choose. The full output is available at /var/log/leapp/leapp-upgrade.log

```bash,run
sudo less /var/log/leapp/leapp-upgrade.log
```

There are other methods for upgrading to the latest version of RHEL using the leapp tooling including the Web Console and Satellite. For those operations, refer to the documentation on Red Hat's website.