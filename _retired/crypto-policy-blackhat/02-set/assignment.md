---
slug: set
id: ytkei8dlml7o
type: challenge
title: Set the system-wide cryptographic policy to FUTURE
tabs:
- id: 8jdeatsrsuzv
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
The Chief Security Officer sends out the following e-mail:
<pre class="file">
Application and Infrastructure Administrators,

I recently returned from an industry security conference, and at that
conference, I learned of some recommended security industry practices
that our Applications and services should be using.  Specifically, we
should disable some less-secure encryption algorithms and enforce some
minimum strength used by others.

Those of you that have applications and services that utilize asymmetric
encryption through RSA based certificates, your certificates should use
at least a 3072 bit public key for their cipher.

TLS connections should only be offered to clients using TLS version 1.2
or higher.  TLS 1.0 and 1.1 should no longer be used for encrypted
connection to services or applications.

Application and services should now be configured to not use SHA1 for
digital signatures.

These changes will allow client data to transit the internet in a more
secure fashion.

-CSO
</pre>

As it happens, all of these requirements can be configured and enforced using
system-wide cryptographic policies that come with Red Hat Enterprise Linux.
In order to comply with the new organization policy, you will update the
system to use the **FUTURE** cryptographic policy.  Changing to the **FUTURE**
policy will configure the cryptography libraries and services used on the
machine or by applications running on the machine such that they comply with
the requirements set forth by the Chief Security Officer above.

```bash
update-crypto-policies --set FUTURE
```

<pre class="file">
Setting system policy to FUTURE
Note: System-wide crypto policies are applied on application start-up.
It is recommended to restart the system for the change to policies
to fully take place.
</pre>

The change will no longer permit some encryption algorithms to be used on the
machine, SHA1 for digital signatures.  Additionally, RSA based certificates
require a public key of at least 3072 bits.  The machine will also now only
offer TLS connections at TLS 1.2 or higher.

You can now verify that the new policy, FUTURE, has been applied to the system.

```bash
update-crypto-policies --show
```

<pre class="file">
FUTURE
</pre>

If you are interested in more details about the cryptographic policies that
ship with Red Hat Enterprise Linux 9:

`man crypto-policies`
