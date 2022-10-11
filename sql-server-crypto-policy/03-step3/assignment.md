---
slug: step3
id: pvrfzq2qyuxs
type: challenge
title: Step 3
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
---
## Reconcile service issues

You will need to restart the Microsoft SQL Server service after changing the system-wide
crypto policy so that it runs under the new policy.

> **NOTE:** Red Hat recommends rebooting the system for all services to be
initialized with the new cryptographic policy, however, for this exercise you
will be individually working with Microsoft SQL Server.

```bash
systemctl restart mssql-server.service
```

Now that SQL Server has restarted, let's try connecting to it using -N option of sqlcmd to
indicate that we want to request an encrypted connection to the server.

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -N
```

<pre class="file">
Sqlcmd: Error: Microsoft ODBC Driver 17 for SQL Server : SSL Provider: [error:1416F086:SSL routines:tls_process_server_certificate:certificate verify failed:EE certificate key too weak]
</pre>

> **NOTE:** The important part is the message at the end indicating certificate key too weak.

Due to the new FUTURE policy, RSA certificates now require a public key of at least 3072 bits.
The FUTURE system-wide crypto policy is stopping sqlcmd from establishing a connection with the
server since running with the existing server certificate, and public key, would violate the policy
settings.  In the next steps, you will resolve this issue.
