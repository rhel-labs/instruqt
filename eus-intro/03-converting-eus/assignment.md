---
slug: converting-eus
id: 5jhbc4ugy0mh
type: challenge
title: Converting a System to EUS Repositories
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Now that your system has the EUS repositories registered, query your system to see how many packages are available for update. (This will be important to note in the next step.)

```
dnf list --updates| wc -l

```

<pre class=file>
# dnf list --updates| wc -l
43
</pre>

It is now time to update to the latest packages in our EUS release. Before proceeding with the update, it is usually advisable to clean the DNF cache as it removes existing metadata and pulls down an updated listing for the new repositories.

```
dnf clean all
dnf update -y

```

Note: Your system's output may vary slightly from the example:

<pre class=file>
# dnf clean all
Updating Subscription Management repositories.
34 files removed

Updating Subscription Management repositories.
Red Hat Enterprise Linux 8 for x86_64 - AppStream(RPMs)       53 MB/s |  45 MB     00:00
Red Hat Enterprise Linux 8 for x86_64 - AppStream - Extended Update Support (RPMs)
... Output Truncated ...
Complete!
</pre>

Now that you have the lastest packages availble in this EUS repositories, verify the minor version of RHEL is the same as Step 2:

```
cat /etc/redhat-release

```

<pre class=file>
Red Hat Enterprise Linux release 8.4 (Ootpa)
</pre>

Notice that with all the latest available packages installed, the server is still running RHEL 8.4. There is a newer EUS release available. In the final step, you will see how to upgrade between EUS versions.
