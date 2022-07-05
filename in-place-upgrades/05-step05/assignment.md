---
slug: step5
type: challenge
title: Step 5
notes:
- type: text
  contents: |
    Depending on the available system resources and the complexity of the operating system instance, the upgrade process can take a long time. It also requires access to the system's console. Due to these conditions, we have provided a screen capture of an identical system upgrade process:

    # TODO Add Screen Capture

    Watch the video then proceed to the final step.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1800
---
# Verifying the upgrade

Once the new initramfs image is in place, packages updates run, and SELinux relabel completion, the system will perform one final reboot. Once that is done, you will be logged into the system's terminal once more. Verify the update was successful by look at the release file from Step 1:

```
cat /etc/redhat-release
```

Note that we are now running the latest version of RHEL 9.

<pre class=file>
# cat /etc/redhat/release
Red Hat Enterprise Linux release 9.0 (Plow)
</pre>

OPTIONAL: You may also review the log file if you so choose. The full output is available at /var/log/leapp/leapp-upgrade.log

```
less /var/log/leapp/leapp-upgrade.log
```

<pre class=file>
# less /var/log/leapp/leapp-upgrade.log

... output truncated ...


</pre>

There are other methods for upgrading to the latest version of RHEL using the leapp tooling including the Web Console and Satellite. For those operations, refer to the documentation on Red Hat's website.