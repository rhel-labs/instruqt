---
slug: reconcile
id: qyrmzrbgcwul
type: challenge
title: Reconcile service issues
tabs:
- id: c80g6jfekqkw
  title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
difficulty: basic
timelimit: 1
enhanced_loading: null
---
You will need to restart the Apache service after changing the system-wide
crypto policy so that it runs under the new policy.

> **NOTE:** Red Hat recommends rebooting the system for all services to be
initialized with the new cryptographic policy, however, for this exercise you
will be individually working with the Apache web service.

```bash
systemctl restart httpd.service
```

<pre class="file">
Job for httpd.service failed because the control process exited with error code.
See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
</pre>

The Apache service fails to restart.  You can see a more specific error
message in the SSL error log for Apache.  You will further diagnose this
using the error messages from the command below and reconcile this in
additional steps in the exercise.

```bash
tail -2 /var/log/httpd/ssl_error_log
```

<pre class="file">
[Tue Jul 16 15:13:25.580860 2019 ] [ssl:emerg] [pid 8869:tid 140233336588544] AH02562: Failed to configure certificate fe80::42:acff:fe11:b:443:0 (with chain), check /etc/pki/tls/certs/localhost.crt
[Tue Jul 16 15:13:25.580860 2019 ] [ssl:emerg] [pid 8869:tid 140233336588544] SSL Library Error: error: 140AB18F: SSL routines: SSL_CTX_use_certificate:ee key too small
</pre>

> **NOTE:** Your log date, time, process ID, or other metadata may be different.  The important part is the message at the end of the entries.

From the log data, the error causing Apache to not start is caused by the
/etc/pki/tls/certs/localhost.crt file.  Recall from the first step, Validate
the Environment, that this file contained an RSA certificate that used a 2048
bit public key.  However, due to the new FUTURE policy, RSA certificates now
require a public key of at least 3072 bits.

The FUTURE system-wide crypto policy is stopping Apache from starting because
running with the existing certificate, and public key, would violate the policy
settings.  In the next steps, you will resolve this issue.
