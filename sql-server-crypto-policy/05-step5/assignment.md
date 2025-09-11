---
slug: step5
id: teunzr8cpwrd
type: challenge
title: Step 5
tabs:
- id: 2ovcbdwigrzr
  title: Terminal
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 1
enhanced_loading: null
---
## Connect to SQL Server with updated certificate

Tune SQL Server configuration to read the new key files, and force encryption only from client

* Set the network.tlscert configuration variable to point to the public key

```bash
/opt/mssql/bin/mssql-conf set network.tlscert /etc/ssl/certs/mssql.pem
```

* Set the network.tlskey configuration variable to point to the private key

```bash
/opt/mssql/bin/mssql-conf set network.tlskey /etc/ssl/private/mssql.key
```

* Set the network.forceencryption configuration variable to 1 (initiated by client)

```bash
/opt/mssql/bin/mssql-conf set network.forceencryption 1
```

Restart the SQL Server service

```bash
systemctl restart mssql-server.service
```

Now that the service certificates comply with the policy, the client should be able to connect
without any issue, and the connection should be encrypted

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Redhat1! -N -C -Q "select session_id, encrypt_option from sys.dm_exec_connections where session_id = @@spid"
```

<pre class="file">
session_id  encrypt_option
----------- ----------------------------------------
         XX TRUE

(1 rows affected)
</pre>
