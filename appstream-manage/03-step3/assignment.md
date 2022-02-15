---
slug: step3
id: zpyqyyzw9vhk
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
An update to the web application running on this system requires features available in postgresql version 10.
To accomplish this you will ultimately remove postgresql 9.6 and install postgresql 10, however, there are some
additional Application Stream settings to apply to the system configuration as well.

To start off with, remove postgresql 9.6.

```bash
yum -y module remove postgresql:9.6
```

Take a look at the Application Stream information for the machine to validate the removal.

```bash
yum  module list postgresql
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Red Hat Enterprise Linux 8 for x86_64-AppStream (RPMs)
Name                 Stream          Profiles
postgresql           9.6 [e]         client, server [d]
postgresql           10 [d]          client, server [d]
postgresql           12              client, server [d]
postgresql           13              client, server [d]

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
</pre>

Verify that postgresql version 9.6 is no longer flagged as [i]nstalled
