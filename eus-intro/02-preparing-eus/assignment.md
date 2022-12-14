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

In order to see which releases are available for your system's current operating system, you will use the `subscription-manager` command:

# Add Image: Show RHEL 8 Lifecycle support bar graph

```
cat /etc/redhat-release
```

<pre class=file>
Red Hat Enterprise Linux release 8.4 (Ootpa)
</pre>

```
# show dnf list --updates | grep (for TOTAL PACKAGES)
```

<pre class=file>

</pre>

# Re-register system (unregister from .latest repos to 8.4 EUS)
# re-run dnf list --updates | grep (for TOTAL PACKAGES)
# dnf update