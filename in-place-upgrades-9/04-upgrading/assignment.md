---
slug: upgrading
id: jpf3l5dgonih
type: challenge
title: Running the Upgrade
tabs:
- title: RHEL
  type: terminal
  hostname: host
difficulty: basic
timelimit: 1
---
# Running the upgrade

Now that you have verified the RHEL system meets all the expected conditions, it is time to kick off the upgrade process:
(Note: This process will take awhile.)

```
leapp upgrade --target 9.2

```

<pre class=file>
# leapp upgrade --target 9.2
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


</pre>

>**Disclaimer:**
The Leapp process can take upwards of 15 minutes to run. Instead of waiting for that process to complete, a second server has been running the upgrade in the background. If you would like to save some time, read the rest of this section, switch to the RHEL2 tab to finish the **Verifying the upgrade** section.

The upgrade has only been _staged_; it has not been completed at this point. A reboot is required for the RHEL 9-based initial RAM disk image (initramfs), upgrades all packages and automatically reboots to the RHEL 9 system.

```
reboot

```

>**Pro Tip:** You can combine these two steps with the --reboot option
`leapp upgrade --target 9.2 --reboot`

The Leapp utility has staged all of the updates. Now, it is performing several actions inside a temporary environment. This includes creating a new initramfs image, relabeling SELinux contexts, and well as cleaning up any remaining RHEL 8 packages.

# Verifying the upgrade

Once the new initramfs image is in place, package updates run, and SELinux relabel completion, the system will perform one final reboot. Once that is done, you will be logged into the system's terminal once more. Finally, we will verify the update was successful by looking at the release file we referenced earlier in the lab:

```
cat /etc/redhat-release

```

Note that we are now running the latest version of RHEL 9!

<pre class=file>
# cat /etc/redhat-release
Red Hat Enterprise Linux release 9.2 (Plow)
</pre>

OPTIONAL: You may also review the log file if you so choose. The full output is available at /var/log/leapp/leapp-upgrade.log

```
less /var/log/leapp/leapp-upgrade.log

```

There are other methods for upgrading to the latest version of RHEL using the leapp tooling including the Web Console and Satellite. For those operations, refer to the documentation on Red Hat's website.