---
slug: start-apache
id: qdjzoz3w6b8x
type: challenge
title: Start Apache with the updated certificates
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
Start the Apache service now that the certificates used comply with the
system-wide crypto policy.  Now that the service complies with the policy,
it should start without further issue.

```bash
systemctl restart httpd.service
```

You can verify the Apache service is now running again.

```bash
systemctl status httpd.service --no-pager
```

<pre class="file">
<< OUTPUT ABRIDGED >>

Active: active (running) since Wed 2019-07-17 09:54:40 EDT; 2s ago

<< OUTPUT ABRIDGED >>
</pre>

Now that the service is running and certificates used comply with the FUTURE
system-wide cryptographic policy, connect to the Apache service and validate
that the new certificate is being offered to client browsers.

```bash
openssl s_client -connect localhost:443 </dev/null 2>/dev/null | grep '^Server public key'
```

<pre class="file">
Server public key is 3072 bit
</pre>
