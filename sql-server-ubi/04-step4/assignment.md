---
slug: step4
id: hguzcnoj45vm
type: challenge
title: Step 4
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Terminal SQL Server
  type: terminal
  hostname: rhel
- title: Terminal SQL Client
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 900
---
## Connect to SQL Server running in the container

In the *Terminal* tab, launch an interactive bash shell in the container connecting to database instance 0 (*mssqlDB0*)

```bash
podman exec -it mssqlDB0 "/bin/bash"
```

Connect with *sqlcmd* and run a T-SQL statement to get the servername and the version of SQL Server running on the server

> **NOTE:** sqlcmd is not in the path by default, so you have to specify the full path

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -Q "select @@servername, @@version"
```

<pre class="file">
-------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
mssqlcontainer0                    Microsoft SQL Server 2019 (RTM-CU8) (KB4577194) - 15.0.4073.23 (X64)
        Sep 23 2020 16:03:08
        Copyright (C) 2019 Microsoft Corporation
        Developer Edition (64-bit) on Linux (Red Hat Enterprise Linux 8.2 (Ootpa)) <X64>

(1 rows affected)
</pre>

Verify that the hostname of the running container is *mssqlcontainer0*, and the version of SQL Server running is 2019.
