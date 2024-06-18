---
slug: step2
id: xtrhggr6zqfh
type: challenge
title: Step 2
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
## Set system-wide cryptographic policy to FUTURE

The Chief Security Officer sends out the following e-mail:
<pre class="file">
Database and Infrastructure Administrators,

I recently returned from an industry security conference, and at that
conference, I learned of some recommended security industry practices
that our Applications and services should be using.  Specifically, we
should disable some less-secure encryption algorithms and enforce some
minimum strength used by others.

Those of you that have applications and services that utilize asymmetric
encryption through RSA based certificates, your certificates should use
at least a 3072 bit public key for their cipher.

Additionally, please ensure that sensitive data in databases is encrypted
at rest for additional protection.

-CSO
</pre>

As it happens, these requirements can be configured and enforced using system-wide cryptographic policies that come with Red Hat Enterprise Linux, and additional database security controls like TDE in SQL Server.

In order to comply with the new organization policy, you will update the system to use the **FUTURE** cryptographic policy.  Changing to the **FUTURE** policy will configure the cryptography libraries and services used on the machine or by applications running on the machine such that they comply with the requirements set forth by the Chief Security Officer above.

```bash
update-crypto-policies --set FUTURE
```

<pre class="file">
Setting system policy to FUTURE
Note: System-wide crypto policies are applied on application start-up.
It is recommended to restart the system for the change to policies
to fully take place.
</pre>

You can now verify that the new policy, FUTURE, has been applied to the system.

```bash
update-crypto-policies --show
```

<pre class="file">
FUTURE
</pre>

If you are interested in more details about the cryptographic policies that ship with Red Hat Enterprise Linux 8:

```bash
man crypto-policies
```
