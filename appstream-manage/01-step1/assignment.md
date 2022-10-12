---
slug: step1
id: husngqy62qxt
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    # Goal:

    After completing this scenario, users will be able to choose which version of a software package is enabled on a system from an application stream.

    # Concepts included in this scenario:
    * Verify the availability of an application stream
    * Install software managed as an application stream
    * Change to a different version of software from an application stream
    * List all available software managed as application streams

    # Example Usecase:

    A web application being deployed on Red Hat Enterprise Linux 8 requires postgresql database version 9.6.  Later, the application is updated and requires postgresql version 10 be available on the machine.

    **Please Note:** The instructions to move the database stored data from postgresql 9.6 to 10 are not included in this scenario, but would likely be needed if an administrator or developer was moving a production system from using postgresql 9.6 to postgresql 10.  Additional administrative activities may be required when performing a move from one version of software to another, including, but not limited to: scheduling a maintenance for the system, notifying users/stakeholders, backing up data, testing post-change, etc.

tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 3420
---
Determine the available versions of postgresql.

```bash
yum module list postgresql
```

<pre class=file>
<< OUTPUT ABRIDGED >>

Red Hat Enterprise Linux 8 for x86_64-AppStream (RPMs)
Name                 Stream         Profiles
postgresql           9.6            client, server [d]
postgresql           10 [d]         client, server [d]
postgresql           12             client, server [d]
postgresql           13             client, server [d]

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
</pre>

There are four versions of postgresql available as modules in the Application Stream, version 9.6, version 10, version 12, and version 13.

postgresql version 10 is set as the default, meaning if someone installed postgresql with no specific options or arguments, version 10 would be the one installed.
