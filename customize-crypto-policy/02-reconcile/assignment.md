---
slug: reconcile
id: qnqdnngtd6ui
type: challenge
title: Reconcile service issues
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---

You will need to restart the Apache service after changing the system-wide
crypto policy so that it runs under the new policy.

> **NOTE:** Red Hat recommends rebooting the system for all services to be
initialized with the new cryptographic policy, however, for this exercise you
will be individually working with the Apache web service.

```bash
systemctl restart httpd.service
```

Verify that Apache is running on the machine.

```bash
systemctl status httpd.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: active (running) since Monday 2019-07-15 19:24:18 EDT; 3h 59min left

<< OUTPUT ABRIDGED >>
</pre>

Now that the service is running and certificates used comply with the modified **FUTURE** policy
that supports shorter key lengths, connect to the Apache service and validate the bit length of
the certificate is being offered to client browsers.

```bash
openssl s_client -connect localhost:443 </dev/null 2>/dev/null | grep '^Server public key'
```

<pre class="file">
Server public key is 2048 bit
</pre>

You have now configured RHEL to enforce a modified **FUTURE** crypto policy that can support 2048-bit or higher
ciphers. Due to this setup, Apache server can continue to run using a 2048-bit server key.
