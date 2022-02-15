---
slug: step5
id: 0cnjl7npa6gc
type: challenge
title: Step 5
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
Launch an interactive bash shell in the container connecting to database instance 0 (*mssqlDB0*)

```bash
podman exec -it mssqlDB0 "/bin/bash"

```## Query In-Memory OLTP data in SQL Server

Run the script to create the in-memory table and load data

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -N -C -i /var/opt/mssql/scripts/imoltp.sql
```

> Let's find out the number of total sessions in the UserSession table

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -d imoltp -N -C -Q "SELECT count(sessionID) FROM dbo.UserSession"
```

<pre class="file">
          6

(1 rows affected)
</pre>

> Let's find out the UserID of the user who has the highest total price items in their shopping cart

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'RedHat1!' -d imoltp -N -C -Q "SELECT top 1 UserID FROM dbo.ShoppingCart order by TotalPrice desc"
```

<pre class="file">
UserID
-----------
        342

(1 rows affected)
</pre>

Exit the bash session

```bash
exit
```
