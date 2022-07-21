---
slug: step4
id: aaawxeyeytx6
type: challenge
title: Step 4
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
# Verifying the upgrade

Once the new initramfs image is in place, package updates run, and SELinux relabel completion, the system will perform one final reboot. Once that is done, you will be logged into the system's terminal once more. Switch back to the terminal tab. Finally, we will verify the update was successful by looking at the release file we referenced earlier in the lab:

```
cat /etc/redhat-release
```

Note that we are now running the latest version of RHEL 9!

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