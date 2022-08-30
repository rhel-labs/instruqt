---
slug: step4
id: aaawxeyeytx6
type: challenge
title: Step 4
notes:
- type: video
  url: ../assets/demo-leapp.mp4
- type: text
  contents: |
    ![Leapp Video](../assets/demo-leapp.mp4)

    The Leapp utility has staged all of the updates. Now, it is performing several actions inside a temporary environment. This includes creating a new initramfs image, relabeling SELinux contexts, and well as cleaning up any remaining RHEL 7 packages.

    # Disclaimer:
    The Leapp process can take upwards of 15 minutes to run. Instead of waiting for that process to complete, a second server has been running the upgrade in the background. This lab will now connect to that second system to complete the conversion process.
tabs:
- title: rhel
  type: terminal
  hostname: host2
difficulty: basic
timelimit: 1800
---
# Verifying the upgrade

Once the new initramfs image is in place, package updates run, and SELinux relabel completion, the system will perform one final reboot. Once that is done, you will be logged into the system's terminal once more. Finally, we will verify the update was successful by looking at the release file we referenced earlier in the lab:

```
cat /etc/redhat-release
```

Note that we are now running the latest version of RHEL 8!

<pre class=file>
# cat /etc/redhat/release
Red Hat Enterprise Linux release 8.6 (Ootpa)
</pre>

OPTIONAL: You may also review the log file if you so choose. The full output is available at /var/log/leapp/leapp-upgrade.log

```
less /var/log/leapp/leapp-upgrade.log
```

There are other methods for upgrading to the latest version of RHEL using the leapp tooling including the Web Console and Satellite. For those operations, refer to the documentation on Red Hat's website.