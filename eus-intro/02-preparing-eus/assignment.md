---
slug: preparing-eus
id: mn4dexksswet
type: challenge
title: Prepare a System for EUS repositories
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

# Preparing a system for EUS

Before you subscribe your system to an EUS release, it is important to note which release your system is running. This information is stored in `/etc/redhat-release`

```
cat /etc/redhat-release
```

<pre class=file>
Red Hat Enterprise Linux release 8.4 (Ootpa)
</pre>

At this point, your system is not configured for EUS. If you were to run a `dnf update` with this configuration, your server would update to the latest minor version (RHEL 8.7 in this case).

In order to see which releases are available for your system's current operating system, you will use the `subscription-manager` command:


```
# show dnf list --updates | grep (for TOTAL PACKAGES)
```

<pre class=file>

</pre>

# Re-register system (unregister from .latest repos to 8.4 EUS)
# re-run dnf list --updates | grep (for TOTAL PACKAGES)
# dnf update