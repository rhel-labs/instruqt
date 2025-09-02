---
slug: gather-information
id: y8snyqbuyys8
type: challenge
title: Gathering System Information
notes:
- type: text
  contents: |
    After completing this scenario, users will be able to identify vulnerabilities that
    affect systems registered to Red Hat Insights using the Red Hat Insights Vulnerability tool.
    They will also learn how to remdediate these vulnerabilities.

    # Concepts included in this scenario:
    * View Red Hat Insights Vulnerability results that are reported for the system on console.redhat.com.
    * Apply a recommeded remediation for the system.
    * Validate that the remediation was successful.

    # Example Usecase:
    You need to report out what systems are impacted by a given vulnerability, or generate
    a report showing what CVEs may impact your fleet for auditing purposes.

    Systems are impacted by a new vulnerability which a remediation exists for.
    Administrators would like to apply specific fixes to their systems without the
    need for broader system updates.
tabs:
- id: gdcdeaun0m7y
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3000
enhanced_loading: null
---
This lab system is already registered with Red Hat's [Hybrid Cloud Console](https://cloud.redhat.com) using the Red Hat Remote Host Configuration utility `rhc`.  We can view its registration information with the following command.

```
rhc status
```

You should get output similar to this:

<pre class=file>
Connection status for rhel-27ff4:

● Connected to Red Hat Subscription Management
● Connected to Red Hat Insights
● The Red Hat connector daemon is active

Manage your Red Hat connector systems: https://red.ht/connector
</pre>

You can see that the system's hostname is included in the output, in this case `rhel-27ff4` your system will have a similarly formatted, but different name. You will need this hostname later, so jot it down.

Let's refresh this hosts insights data, and then continue.

Run the following command on your host

```bash
insights-client
```

